Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbTKMK7F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 05:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTKMK7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 05:59:05 -0500
Received: from razorbill.mail.pas.earthlink.net ([207.217.121.248]:62604 "EHLO
	razorbill.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263871AbTKMK7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 05:59:00 -0500
From: Guy <fsos_guy@earthlink.net>
Organization: C
To: linux-kernel@vger.kernel.org
Subject: 2.6 scheduler and "fast user switching"
Date: Thu, 13 Nov 2003 04:30:02 -0500
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311130430.06882.fsos_guy@earthlink.net>
X-ELNK-Trace: d501ffacebf681585e89bb4777695beb702e37df12b9c9efcc01d6fe9dc10654ad57023ad585b224350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scenario:

I typically log in as 'root' on the first console. I then invoke 
fluxbox as the GUI.

# XSESSION=fluxbox startx -- :0

I then ctl-alt-F2 another console and login as 'user1'. I then 
invoke KDE as the GUI.

$ XSESSION=kde-3.1.4 startx -- :1

I may or may not ctl-alt-Fn and login as 'usern' and repeat the 
process.

Several thoughts:

1} I've seen Nick Piggin's suggestion of nicing X server to -10. 
At the moment, the only way I know to do this is something like

# XSESSION=fluxbox nice --adjustment=-10 startx -- :N

A} My default security is that only 'root' can perform nice with 
negative values. I am reluctant to play with security for such a 
crticial command.

B} All child threads inherit the new nice value. So in the example 
just above, this means all applications started from the GUI 
desktop run at a nice value of -10. I believe enhancing the X 
server nice value this way defeats the purpose of nicing it to 
begin with. Obviously, despite my readings and attempts at 
research, I'm must be missing something here.

2} I expect to travel down to Florida for Xmass to visit family. 
One of the things I had hoped to do was to set up my mother's 
computer as an X server and hang a thin client terminal {read: 
older PC} off of it. This would allowed my mother and brother to 
share a reasonably modern system at the same time.

This is not me just being cheap. I'm interested in setting up 
diskless workstations aound a good central X server. I see such 
setups as appropriate for a number of situations. If the X server 
requires 'nicing' in a single user environment, what happens in 
an LTSP environment?

My base reference environment is 2.4.20. I still actively use it 
for everything I do as everything works as expected. 

Despite my enthusiasm for 2.6, I find it difficult to get 
everything to 'just work'. I still see problems in the area of 
nForce based mobos {stupid proprietary nVidia!}, broken BIOSes, 
and scheduler issues like the above.

Flames, instruction, suggestions, thoughts would be appreciated.

FWIW, I'm not a C/C++ programmer. I'm computer literate and am not 
afraid to run bleeding edge.

Guy

-- 
Recyle computers. Install Gentoo GNU/Linux.

