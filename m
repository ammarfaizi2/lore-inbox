Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWJQVMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWJQVMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWJQVMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:12:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:53509 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750701AbWJQVMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:12:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=nZgBD3CxZZ0w3HhcXgkp0nheDvQ0+qjJs/s5ZAUdGYro2/2GEi8Ywu858XT+NzcB0KkWUl2tFmsRzjSu+IQRDnt0tBc8RczMouUhFmItFIhjjksv+QQMfSpPFYXhRwgcwFR84SJtFkm7OBywdwF831leMN1XnXl4EWAc/dkEqu8=
Message-ID: <d120d5000610171412hd20c08xda772afca14394a8@mail.gmail.com>
Date: Tue, 17 Oct 2006 17:12:11 -0400
From: "Dmitry Torokhov" <dtor@insightbb.com>
To: "Greg.Chandler@wellsfargo.com" <Greg.Chandler@wellsfargo.com>
Subject: Re: Touchscreen hardware hacking/driver hacking.
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
X-Google-Sender-Auth: 6e01a63ffadf5f12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/06, Greg.Chandler@wellsfargo.com <Greg.Chandler@wellsfargo.com> wrote:
>
> I'm working on a prototype Hitachi tablet, it uses a Fujitsu 4-wire
> resistive touchscreen. {10.4" I think}
> I've found that windows-xp embedded uses a generic ps/2 driver for the
> device.
>
> I've ripped this thing to pieces on several occasions looking for chips
> to help the porting, my problem is that I can not find the
> analog-digital converter for this thing.  The connector goes to a
> surface mount header on an 8 layer board.
> I loose the traces almost instantly.  Given that I can't find the
> converter anywhere what should I do next?
>
> I've done my homework and found that this HAS to be either serial or usb
> attached according to Fujitsu.
> Aparently it's neither.  There are no unknown USB devices {or known
> matching}, and there is no activity on the single serial port on the
> system.  Since the windows driver uses PS/2 as the interface I have a
> horrible feeling this thing has an interpretation layer that makes it a
> PS/2 mouse, and that may or may not royally be a nightmare.
>

The touchscreen might need a "magic knock" to activate. You might try
to see what data wondows driver sends to PS/2 port.

Also check of Lifebook touchscreen protocol will work for you. You
will need to adjust DMI table in drivers/input/mouse/lifebook.c/

> I would have posted this to a different group but there is no "input"
> mailing list.
>

linux-input@atrey.karlin.mff.cuni.cz

But you must be subscribed to post otherwise list just drops your
mails on the floor.

-- 
Dmitry
