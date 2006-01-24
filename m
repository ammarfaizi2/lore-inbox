Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbWAXSlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbWAXSlX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWAXSlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:41:23 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:4239 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932465AbWAXSlW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:41:22 -0500
Date: Tue, 24 Jan 2006 18:41:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Jones <davej@redhat.com>, Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export symbols so CONFIG_INPUT works as a module
Message-ID: <20060124184114.GS27946@ftp.linux.org.uk>
References: <20060124181945.GA21955@deprecation.cyrius.com> <20060124183432.GA27917@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124183432.GA27917@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 01:34:32PM -0500, Dave Jones wrote:
> On Tue, Jan 24, 2006 at 06:19:45PM +0000, Martin Michlmayr wrote:
>  > Currently, modular input support fails to load with the following error:
>  > 
>  > qube:# modprobe input
>  > input: Unknown symbol kobject_get_path
>  > input: Unknown symbol add_input_randomness
>  > 
>  > In the short run, this can be solved by exporting these two symbols.
>  > There have been discussions about fixing this in a different manner,
>  > see http://www.ussg.iu.edu/hypermail/linux/kernel/0505.2/1068.html
>  > Since this was in the days of 2.6.12-rc4 and modular input support is
>  > still broken, I suggest these symbols to be exported for now.
> 
> Is there actually any practical reason why you would want to
> make the input layer modular ?

More interesting question: is pis^H^H^Hsysfs interaction in there safe for
modular code?
