Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262743AbSJaR0Q>; Thu, 31 Oct 2002 12:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJaR0Q>; Thu, 31 Oct 2002 12:26:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:64251 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262743AbSJaR0F>; Thu, 31 Oct 2002 12:26:05 -0500
Subject: Re: How to get a local IPv4 address from within a kernel module?
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF3A0A864F.BCE2D0BA-ON87256C63.006000B8@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Thu, 31 Oct 2002 09:32:29 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/31/2002 10:32:29
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                               
                                                                                                               
                                                                                                               


Jean,

I am aware of all this, however, my application will be happy to get any
IPv4 assigned to any of the local interfaces as far as you consistently
get the same on repeated calls.
I think there should be an interface to query this from within the kernel
so since I did not find it I am proposing to get one
or may be there is something hidden which I missed so I decided to ask
here.

Juan




|---------+---------------------------------->
|         |           Jean Tourrilhes        |
|         |           <jt@bougret.hpl.hp.com>|
|         |           Sent by:               |
|         |           linux-kernel-owner@vger|
|         |           .kernel.org            |
|         |                                  |
|         |                                  |
|         |           10/30/02 06:38 PM      |
|         |           Please respond to jt   |
|         |                                  |
|---------+---------------------------------->
  >------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                  |
  |       To:       Linux kernel mailing list <linux-kernel@vger.kernel.org>                                         |
  |       cc:                                                                                                        |
  |       Subject:  Re: How to get a local IPv4 address from within a kernel module?                                 |
  |                                                                                                                  |
  |                                                                                                                  |
  >------------------------------------------------------------------------------------------------------------------|



Juan Gomez wrote :
>
> Is there any standard way of doing this? I looked into ipv4 code but I
did
> not find a function that would provide a direct, clean way to query the
> local IPv4 addresses of a given node.

             There is no such thing as the local IPv4 addresses of a given
node. IP addresses are assigned for each network interfaces, so you
may have more than one IP address. Note that I have many systems that
don't have any "eth0" and still have many IP addresses (on wlan0,
ppp0, bnep0...).
             On top of that, the DNS may assign an IP address that map to
your current hostname (which may correspond to one of the addresses
above). That's purely a user space stuff.

             So, you are basically starting on a wrong assumption, the
information you are looking for doesn't exist, and I therefore suspect
that you need to rethink the thing you want to do.

             I suggest you use a user space application to pick the IP
address most relevant to your setup (i.e. policy decision) and inject
it in your module.

             Good luck,

             Jean
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



