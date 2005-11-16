Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVKPSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVKPSVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbVKPSVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:21:17 -0500
Received: from bay108-f28.bay108.hotmail.com ([65.54.162.38]:24002 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1030384AbVKPSVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:21:16 -0500
Message-ID: <BAY108-F28B7CC69DF16CE43313513C05C0@phx.gbl>
X-Originating-IP: [66.92.248.193]
X-Originating-Email: [joneserstein@hotmail.com]
In-Reply-To: <437ABC1E.7040301@gmail.com>
From: "Jones Joneser" <joneserstein@hotmail.com>
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Tyan s2822 and SATA slowness / erratic speeds kernel 2.6
Date: Wed, 16 Nov 2005 18:21:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Nov 2005 18:21:16.0392 (UTC) FILETIME=[88820680:01C5EADA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We experience the same issue when using an LSI SATA controller and the Tyan 
motherboard.  In addition we did try vanilla 2.6.14.2 and experienced the 
same slowdown issues.

-asher

<BLOCKQUOTE style='PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #A0C6E5 
2px solid; MARGIN-RIGHT: 0px'><font 
style='FONT-SIZE:11px;FONT-FAMILY:tahoma,sans-serif'><hr color=#A0C6E5 
size=1>
From:  <i>Tejun Heo &lt;htejun@gmail.com&gt;</i><br>To:  <i>Jones Joneser 
&lt;joneserstein@hotmail.com&gt;</i><br>CC:  <i>linux-ide@vger.kernel.org, 
linux-scsi@vger.kernel.org,linux-kernel@vger.kernel.org</i><br>Subject:  
<i>Re: PROBLEM: Tyan s2822 and SATA slowness / erratic speeds kernel 
2.6</i><br>Date:  <i>Wed, 16 Nov 2005 13:57:02 +0900</i><br>MIME-Version:  
<i>1.0</i><br>Received:  <i>from vger.kernel.org ([209.132.176.167]) by 
MC6-F11.hotmail.com with Microsoft SMTPSVC(6.0.3790.211); Tue, 15 Nov 2005 
21:00:16 -0800</i><br>Received:  <i>(majordomo@vger.kernel.org) by 
vger.kernel.org via listexpandid S932296AbVKPE5M (ORCPT 
&lt;rfc822;joneserstein@hotmail.com&gt;);Tue, 15 Nov 2005 23:57:12 
-0500</i><br>Received:  <i>(majordomo@vger.kernel.org) by vger.kernel.org id 
S932580AbVKPE5M(ORCPT &lt;rfc822;linux-scsi-outgoing&gt;);Tue, 15 Nov 2005 
23:57:12 -0500</i><br>Received:  <i>from zproxy.gmail.com 
([64.233.162.197]:62641 &quot;EHLO zproxy.gmail.com&quot;)by vger.kernel.org 
with ESMTP id S932579AbVKPE5L 
(ORCPT&lt;rfc822;linux-scsi@vger.kernel.org&gt;);Tue, 15 Nov 2005 23:57:11 
-0500</i><br>Received:  <i>by zproxy.gmail.com with SMTP id 13so1684427nzn 
for &lt;linux-scsi@vger.kernel.org&gt;; Tue, 15 Nov 2005 20:57:10 -0800 
(PST)</i><br>Received:  <i>by 10.36.3.15 with SMTP id 15mr5939412nzc; Tue, 
15 Nov 2005 20:57:10 -0800 (PST)</i><br>Received:  <i>from htj.dyndns.org ( 
[221.139.199.105]) by mx.gmail.com with ESMTP id 
23sm199490nzn.2005.11.15.20.57.07; Tue, 15 Nov 2005 20:57:09 -0800 
(PST)</i><br>Received:  <i>from [127.0.0.1] (htj.dyndns.org 
[127.0.0.1])(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))(No 
client certificate requested)by htj.dyndns.org (Postfix) with ESMTP id 
DC824184063;Wed, 16 Nov 2005 13:57:02 +0900 (KST)</i><br>&gt;Jones Joneser 
wrote:<br>&gt; &gt; Machine:<br>&gt; &gt; Tyan s2822G3NR-D<br>&gt; &gt; 
Silicon Image, Inc. SiI 3114<br>&gt; &gt; SATA Drives: Western Digital 300gb 
/ seagate 80 gb<br>&gt; &gt;<br>&gt; &gt; Initially we thought we had a 
network issue because we were seeing a<br>&gt; &gt; slowdown when 
transferring files &gt; 512Mb in size (by whatever method:<br>&gt; &gt; 
rsync, cp, scp, etc.) between two of the Tyan servers, we see the 
first<br>&gt; &gt; 512Mb go at a decent rate (tens of megabytes per second) 
and then the<br>&gt; &gt; rate plummets to below 500k/sec.   However we 
reproduce the issue<br>&gt; &gt; locally on a machine thus eliminating the 
network card issue. We also<br>&gt; &gt; had tried with different ethernet 
cards and x-over cable.<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; We are using 
CentOS 4 and have tried both 4.1 and 4.2 (the latest<br>&gt; &gt; edition) 
64 and 32 bit.  We have tried ubuntu, gentoo, and vanilla<br>&gt; &gt; 
kernels.  We have upgraded our BIOS to the latest and experimented 
with<br>&gt; &gt; different BIOS settings (from 'safe' to 'optimal' with 
many variants in<br>&gt; &gt; between.) We have tried it with ACPI switched 
off, with 4gb of RAM and<br>&gt; &gt; with 8gb of RAM. We have upgraded the 
BIOS to 3.04 &amp; then 3.05.  The<br>&gt; &gt; best we get is that under 
the ubuntu, gentoo, and a 2.4 kernel we can<br>&gt; &gt; see stable 
performance that is well below what we should be getting<br>&gt; &gt; 
~20MiB/s.<br>&gt; &gt;<br>&gt; &gt; No matter what combination of 
configuration we try, we consistently see<br>&gt; &gt; this issue.  We have 
even tried and LSI SATA controller w/ Tyan<br>&gt; &gt; motherboard and 
experienced the same issues.<br>&gt; &gt;<br>&gt; &gt; We moved the SATA 
controller to a Dell PE 1750 and experience none of<br>&gt; &gt; the 
slowdowns, consistent ly 45-50MiB/s performance with no erraticness<br>&gt; 
&gt; in speed or drops in performance.<br>&gt; &gt;<br>&gt; &gt; We suspect 
the issue is related to the combo of the Tyan mobo with the<br>&gt; &gt; 
SATA controller subsystem but need some assistance in further 
nailing<br>&gt; &gt; down the cause and solution to this issue.<br>&gt; 
&gt;<br>&gt; &gt; Let me know of any additional information that I can 
provide to assist<br>&gt; &gt; with the debugging of this issue.<br>&gt; 
&gt;<br>&gt; &gt; Thanks,<br>&gt; &gt; -asher<br>&gt; &gt;<br>&gt;<br>&gt;i. 
posting boot message would help.<br>&gt;ii. Can you try vanilla 2.6.14 
kernel?  If it's sil m15w problem and<br>&gt;your card is 3114 but not 3112, 
the problem should disappear on 
2.6.14.<br>&gt;<br>&gt;--<br>&gt;tejun<br>&gt;-<br>&gt;To unsubscribe from 
this list: send the line &quot;unsubscribe linux-scsi&quot; in<br>&gt;the 
body of a message to majordomo@vger.kernel.org<br>&gt;More majordomo info at 
  http://vger.kernel.org/majordomo-info.html<br></font></BLOCKQUOTE>


