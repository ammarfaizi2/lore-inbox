Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264954AbUELEAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbUELEAq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265006AbUELEAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:00:46 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:47777 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264954AbUELEAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:00:44 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Todd Poynor <tpoynor@mvista.com>
Subject: Re: Hotplug events for system suspend/resume
Date: Wed, 12 May 2004 13:59:50 +1000
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, mochel@digitalimplant.org,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20040511010015.GA21831@dhcp193.mvista.com> <200405121216.02787.ncunningham@linuxmail.org> <40A18F94.4000607@mvista.com>
In-Reply-To: <40A18F94.4000607@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405121359.50899.ncunningham@linuxmail.org>
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 12 May 2004 12:44, Todd Poynor wrote:
> The patch hooks into the power subsystem prior to freezing processes and
> after unfreezing processes, so I don't think it's a concern (unless
> something is using the power subsystem rather oddly).  This patch sends
> a single notification of system suspend and a single notification of
> system resume, in case there's any confusion with the individual device
> state change notifiers also recently discussed.  It's been run
> successfully on one ACPI system and one non-ACPI system.

Great.

> > In my mind, this approach is simpler and makes more sense: userspace
> > should worry about userspace actions related to suspending before calling
> > kernelspace. Kernel space should then only worry about saving and
> > restoring driver states and should be transparent to user space. ...
>
> Agreed, with the minor reservations listed in a previous email (suspend
> initiated by drivers must coordinate ad-hoc with userspace, etc.).

You're thinking ACPI drivers initiating a suspend? They would do it through 
acpid, wouldn't they? At least that's the glue I use to get my sleep button 
to initiate a suspend. I would assume thermal events would/should work the 
same.

> I'll let anybody who cares more deeply about this speak up now,
> otherwise this isn't a battle I'll be fighting on behalf of others any
> more.  Thanks -- Todd

:> I wasn't meaning to make it a battle!

Nigel

