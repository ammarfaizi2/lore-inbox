Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWEBS2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWEBS2B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 14:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWEBS2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 14:28:01 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:29636 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S964957AbWEBS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 14:28:01 -0400
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
	userspace (Xorg) to enable devices without doing foul direct access
From: Arjan van de Ven <arjan@linux.intel.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
In-Reply-To: <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>
	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>
	 <44578C92.1070403@linux.intel.com>
	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
	 <44579028.1020201@linux.intel.com>
	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 20:27:37 +0200
Message-Id: <1146594457.32045.91.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-02 at 13:13 -0400, Jon Smirl wrote:
> On 5/2/06, Arjan van de Ven <arjan@linux.intel.com> wrote:
> > Jon Smirl wrote:
> > > All of these have been proposed before.
> >
> > I think you forgot to attach the patch
> >
> > > In my opinion an 'enable'
> > > attribute is the worst solution in the bunch.
> >
> > you again limit yourself to VGA. I don't.
> 
> Haven't we learned that mucking with hardware from user space without
> having a device driver loaded is a very bad idea.

Not quite. It needs a reasonable sane userspace sure, but it's not
unreasonable for several cases.

>   What is the
> motivation for providing an API whose only purpose is to enable this
> bad behavior?

you're very selective in what you read and only think about X.
There's many other reasons to enable/disable devices post boot. 
Having a driver just to call pci_enable_device() is silly; and
there are various scenarios you may want. Userland suspend/resume is
only one of those, posting video cards is one, chip health monitoring is
one, etc etc etc. Don't let your lack of imagination ruin things.


