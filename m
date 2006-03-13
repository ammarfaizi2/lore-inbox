Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWCMWaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWCMWaS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbWCMWaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:30:18 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:8387 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964813AbWCMWaQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:30:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Oh/RmZmxfiCto2LhGzK8ib31kksgOOP5LxOMiYQkKJFRDzSTJzkpqxCi59C1Q/qK1+vZEQ/dKnV1Ga7v8cpLEYqSytaYFSYRoJCphemHIikPKjxPAcdbj4PW8YOAXlAk5wmfq2G92Ll2peeUQgDkcUbLVYwzjf6ni+aZN3ux/c0=
Message-ID: <56a8daef0603131430x8fd17fbn4aa5b5082e8aad0e@mail.gmail.com>
Date: Mon, 13 Mar 2006 14:30:15 -0800
From: "John Ronciak" <john.ronciak@gmail.com>
To: "Pierre Ossman" <drzeus-list@drzeus.cx>
Subject: Re: e1000 with serdes only shows a fiber port
Cc: LKML <linux-kernel@vger.kernel.org>, cramerj@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
In-Reply-To: <44157178.90507@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44157178.90507@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/06, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> Hi!
>
> I'm having problems with the e1000 card in a Dell Poweredge 1855. This
> model has support for both copper and fiber and has two cards on the PCI
> bus (might supposed to be one for each type).

If it's a blade server blade then it's really not fiber or copper
(i.e. no PHY), it's a serdes connection to the backplane in the blade
server.  I have never seen one of these not always have link (if the
blade is plugged into the backplane it must have link).

So what versions of things are you running?  OS? Driver?  Version
number of the blade?  BIOS (must have the latest)?  Windows doesn't
use the BIOS but does everything itself regarding HW setup.

Did you go back to Dell for support on this?  What did they say?  Are
you using a version of Linux that Dell supports on this hardware? 
There might need to be some special drivers that are needed which Dell
supplies with their versions for specific HW.  I'm not a blade server
expert but I've seen things like this before.

One suggestion is to disable auto-negotiation and force the link to 1
gigabit full duplex to see what that does.

Let us know.

--
Cheers,
John
