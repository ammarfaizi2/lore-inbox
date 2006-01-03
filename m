Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWACTcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWACTcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWACTcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:32:19 -0500
Received: from mx2.perftech.si ([195.246.0.30]:41234 "EHLO mx2.perftech.si")
	by vger.kernel.org with ESMTP id S932498AbWACTcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:32:18 -0500
Date: Tue, 03 Jan 2006 20:31:41 +0100
From: "xerces8" <xerces8@butn.net>
To: tech@lists.gnumonks.org, linux-kernel@vger.kernel.org
Subject: Re: Possible GPL violation in Canyon CN-WF514 WLAN router
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <WorldClient-F200601032031.AA31410090@butn.net>
X-Mailer: WorldClient 8.1.3
In-Reply-To: <WorldClient-F200512251652.AA52540032@butn.net>
References: <WorldClient-F200512251652.AA52540032@butn.net>
X-Authenticated-Sender: xerces8@butn.net
X-Return-Path: xerces8@butn.net
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Spam-Report: * -100 USER_IN_WHITELIST From: address is in the whitelist
X-Spam-Processed: butn.net, Tue, 03 Jan 2006 20:31:58 +0100
X-MDAV-Processed: butn.net, Tue, 03 Jan 2006 20:32:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(lkml readers please consider replying to me or tech and not to lkml)

I posted [1] on the GPL-violations mailing list, but got no response, so I'll
try here.

What :

  It seems Canyon [2] distributes [3] a firmware update file [4]
  for their CN-WF514 WLAN router that contains the linux kernel
  image. nmap scan guesses the router is running "Linux 2.4.X|2.5.X"
  There is no mention of used GPL software and no source code.
  A direct enquiry to Canyon was responded with : 

This product is not using GNU GPL license.

(yes, that's all of it)


What I need : 

 Help disecting the FW package [4]. It is a ZIP archive containing 
 a text file and a *.bin file. This *.bin file appears to be some kind
 of another archive, containing two files : webpages-6104ipc.bin
 and vmlinux.bin
 The *.bin archive file begins with the string "WBIP". I guess it uses
 compression, since "strings" does not give out anything useful, except
 the mentioned two filenames.
 There[3] is another firmware update [5] that is in slightly different
 format. "strings" there finds this :

RtosTxImage
Uncompressing Linux...
Ok, booting the kernel.


Any ideas ?

As this is partly off topic for lkml, I suggest replying to the gpl
violations mail list.

Here is what I asked Canyon and got the above answer :

Is any software distributed with the CN-WF514 router,
that is licensed under the GNU General Public License ?

Hm, maybe they thought I'm talking about the acompanying
CD media ...

Regards,
David Balazic


[1] http://lists.gpl-violations.org/pipermail/tech/2005-December/000052.html
[2] http://www.canyon-tech.com/
[3]
http://www.canyon-tech.com/products/show.cfm/Networking/Net/Wireless_Products_IEEE_802.11g/CN-WF514/Down
[4] http://www.canyon-tech.com/files/Canyon/Networking/WiFi_U/CN-WF514/WF514-208.zip
[5] http://www.canyon-tech.com/files/Canyon/Networking/WiFi_U/CN-WF514/WF514-200713T5.zip

-----Original Message-----
From: "xerces8" <xerces8@butn.net>
To: tech@lists.gpl-violations.org
Date: Sun, 25 Dec 2005 16:52:54 +0100
Subject: Possible GPL violation in Canyon CN-WF514 WLAN router

> Hi!
> 
> I suspect a GPL violation with the product Canyon CN-WF514 WLAN router [1].
> There is a firware update file on the web [2] for it.
> The file is WF514-208.zip [3] and contains a file named WF514_208.bin.
> Some strings in it are :
>  - WBIP  - at offset 0, is this some file format ID ?
>  - webpages-6104ipc.bin , a few bytes later
>  - vmlinux.bin - some more bytes later
> 
> It appears to be some archive with at least the two above files.
> It is probably compressed, as ZIP-ing it does not reduce the size.
> 
> Also, running nmap -O against a running CN-WF514 guesses that it is
> running linux 2.4.x|2.5.x.
> 
> Note, that there is another (older) WLAN router made by Canyon, the
> CN-WF512 [4]. Its page tells, that is uses GPL software and the software
> (sources) is available for download.
> 
> What should I do next ?
> Analyze the FW ?
> Write them a letter ?
> 
> Best regards,
> David Balazic
> 
> [1]
> http://www.canyon-tech.com/products/show.cfm/Networking/Net/Wireless_Products_IEEE_802.11g/CN-WF5
> 14
> [2]
> http://www.canyon-tech.com/products/show.cfm/Networking/Net/Wireless_Products_IEEE_802.11g/CN-WF5
> 14/Down
> [3] http://www.canyon-tech.com/files/Canyon/Networking/WiFi_U/CN-WF514/WF514-208.zip
> [4] http://www.canyon-tech.com/products/show.cfm/Net/Wireless_Products_IEEE_802.11g/CN-WF512/
> 
> 
> 


