Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUJIQF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUJIQF4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 12:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUJIQF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 12:05:56 -0400
Received: from village.ehouse.ru ([193.111.92.18]:58375 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S266901AbUJIQFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 12:05:38 -0400
From: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
To: "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: Megaraid random loss of luns
Date: Sat, 9 Oct 2004 20:05:27 +0400
User-Agent: KMail/1.7
Cc: comsatcat@earthlink.net, linux-kernel@vger.kernel.org
References: <0E3FA95632D6D047BA649F95DAB60E57033BCAD6@exa-atlanta>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BCAD6@exa-atlanta>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410092005.28072.rathamahata@ehouse.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
On Friday 08 October 2004 16:51, Mukker, Atul wrote:
> I _highly_ recommend to replace the default driver with the latest 2.20.4.0
> driver and retry.

After driver upgrade I found next messages in the log (I had never
seen thous messages before this):

Oct  9 00:15:50 [kernel] megaraid: aborting-3511338 cmd=2a <c=1 t=0 l=0>
Oct  9 00:16:02 [kernel] megaraid mbox: Wait for 3 commands to complete:175
Oct  9 00:24:38 [kernel] megaraid: aborting-3598937 cmd=2a <c=1 t=0 l=0>
Oct  9 00:26:57 [kernel] megaraid: aborting-3606096 cmd=2a <c=1 t=0 l=0>
Oct  9 00:26:57 [kernel] megaraid abort: 3606096:9[255:0], fw owner
Oct  9 00:27:27 [kernel] megaraid mbox: Wait for 6 commands to complete:175
Oct  9 00:37:09 [kernel] megaraid: aborting-3672953 cmd=2a <c=1 t=0 l=0>
Oct  9 00:50:25 [kernel] megaraid: aborting-3720862 cmd=2a <c=1 t=0 l=0>
Oct  9 01:08:13 [kernel] megaraid: aborting-3809924 cmd=2a <c=1 t=0 l=0>
Oct  9 01:49:45 [kernel] megaraid: aborting-4094075 cmd=2a <c=1 t=0 l=0>
Oct  9 02:16:50 [kernel] megaraid: aborting-4407834 cmd=2a <c=1 t=0 l=0>
Oct  9 03:01:03 [kernel] megaraid: aborting-4812982 cmd=2a <c=1 t=0 l=0>
Oct  9 03:01:06 [kernel] megaraid mbox: reset sequence completed sucessfully
Oct  9 03:42:49 [kernel] megaraid: aborting-5020448 cmd=2a <c=1 t=0 l=0>


And...

megaraid: aborting-3810126 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810126, do now own
megaraid: aborting-3810127 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810127, do now own
megaraid: aborting-3810128 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810128, do now own
megaraid: aborting-3810132 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810132, do now own
megaraid: aborting-3810137 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810137, do now own
megaraid: aborting-3810138 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810138, do now own
megaraid: aborting-3810140 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810140, do now own
megaraid: aborting-3810141 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810141, do now own
megaraid: aborting-3810142 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810142, do now own
megaraid: aborting-3810143 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810143, do now own
megaraid: aborting-3810146 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810146, do now own
megaraid: aborting-3810147 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810147, do now own
megaraid: aborting-3810148 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810148, do now own
megaraid: aborting-3810149 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810149, do now own
megaraid: aborting-3810156 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810156, do now own
megaraid: aborting-3810158 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810158, do now own
megaraid: aborting-3810160 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810160, do now own
megaraid: aborting-3810161 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810161, do now own
megaraid: aborting-3810162 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810162, do now own
megaraid: aborting-3810163 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810163, do now own
megaraid: aborting-3810164 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810164, do now own
megaraid: aborting-3810165 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810165, do now own
megaraid: aborting-3810166 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810166, do now own
megaraid: aborting-3810167 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810167, do now own
megaraid: aborting-3810168 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810168, do now own
megaraid: aborting-3810169 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810169, do now own
megaraid: aborting-3810170 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810170, do now own
megaraid: aborting-3810171 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810171, do now own
megaraid: aborting-3810172 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810172, do now own
megaraid: aborting-3810173 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810173, do now own
megaraid: aborting-3810174 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810174, do now own
megaraid: aborting-3810175 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810175, do now own
megaraid: aborting-3810176 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810176, do now own
megaraid: aborting-3810177 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810177, do now own
megaraid: aborting-3810180 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810180, do now own
megaraid: aborting-3810201 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810201, do now own
megaraid: aborting-3810205 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810205, do now own
megaraid: aborting-3810208 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810208, do now own
megaraid: aborting-3810210 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810210, do now own
megaraid: aborting-3810211 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810211, do now own
megaraid: aborting-3810222 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810222, do now own
megaraid: aborting-3810242 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:3810242, do now own
megaraid: aborting-4094075 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094075, do now own
megaraid: aborting-4094078 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094078, do now own
megaraid: aborting-4094083 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094083, do now own
megaraid: aborting-4094084 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094084, do now own
megaraid: aborting-4094085 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094085, do now own
megaraid: aborting-4094086 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094086, do now own
megaraid: aborting-4094087 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094087, do now own
megaraid: aborting-4094088 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094088, do now own
megaraid: aborting-4094092 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094092, do now own
megaraid: aborting-4094093 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094093, do now own
megaraid: aborting-4094094 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094094, do now own
megaraid: aborting-4094095 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094095, do now own
megaraid: aborting-4094096 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094096, do now own
megaraid: aborting-4094097 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094097, do now own
megaraid: aborting-4094098 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094098, do now own
megaraid: aborting-4094099 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094099, do now own
megaraid: aborting-4094100 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094100, do now own
megaraid: aborting-4094102 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094102, do now own
megaraid: aborting-4094104 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094104, do now own
megaraid: aborting-4094106 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094106, do now own
megaraid: aborting-4094107 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094107, do now own
megaraid: aborting-4094110 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094110, do now own
megaraid: aborting-4094111 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094111, do now own
megaraid: aborting-4094113 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094113, do now own
megaraid: aborting-4094114 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094114, do now own
megaraid: aborting-4094115 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094115, do now own
megaraid: aborting-4094117 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094117, do now own
megaraid: aborting-4094119 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094119, do now own
megaraid: aborting-4094129 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094129, do now own
megaraid: aborting-4094130 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094130, do now own
megaraid: aborting-4094132 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094132, do now own
megaraid: aborting-4094134 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094134, do now own
megaraid: aborting-4094136 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4094136:96[255:0], fw owner
megaraid: aborting-4094137 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094137, do now own
megaraid: aborting-4094138 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094138, do now own
megaraid: aborting-4094141 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094141, do now own
megaraid: aborting-4094142 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094142, do now own
megaraid: aborting-4094143 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094143, do now own
megaraid: aborting-4094147 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094147, do now own
megaraid: aborting-4094149 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094149, do now own
megaraid: aborting-4094150 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094150, do now own
megaraid: aborting-4094151 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094151, do now own
megaraid: aborting-4094153 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094153, do now own
megaraid: aborting-4094154 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094154, do now own
megaraid: aborting-4094155 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094155, do now own
megaraid: aborting-4094156 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094156, do now own
megaraid: aborting-4094157 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094157, do now own
megaraid: aborting-4094158 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094158, do now own
megaraid: aborting-4094159 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4094159, do now own
megaraid: reseting the host...
megaraid mbox: reset sequence completed sucessfully
megaraid: aborting-4407834 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407834, do now own
megaraid: aborting-4407836 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407836, do now own
megaraid: aborting-4407838 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407838, do now own
megaraid: aborting-4407854 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407854, do now own
megaraid: aborting-4407856 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407856, do now own
megaraid: aborting-4407860 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407860, do now own
megaraid: aborting-4407862 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:4407862, do now own
megaraid: aborting-4812982 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812982:107[255:0], fw owner
megaraid: aborting-4812983 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812983:37[255:0], fw owner
megaraid: aborting-4812984 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812984:86[255:0], fw owner
megaraid: aborting-4812986 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812986:43[255:0], fw owner
megaraid: aborting-4812987 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812987:84[255:0], fw owner
megaraid: aborting-4812988 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812988:12[255:0], fw owner
megaraid: aborting-4812989 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812989:56[255:0], fw owner
megaraid: aborting-4812990 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812990:1[255:0], fw owner
megaraid: aborting-4812991 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812991:85[255:0], fw owner
megaraid: aborting-4812992 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812992:24[255:0], fw owner
megaraid: aborting-4812993 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812993:40[255:0], fw owner
megaraid: aborting-4812994 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812994:52[255:0], fw owner
megaraid: aborting-4812995 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812995:101[255:0], fw owner
megaraid: aborting-4812996 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812996:78[255:0], fw owner
megaraid: aborting-4812997 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812997:35[255:0], fw owner
megaraid: aborting-4812998 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812998:80[255:0], fw owner
megaraid: aborting-4812999 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4812999:28[255:0], fw owner
megaraid: aborting-4813000 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813000:94[255:0], fw owner
megaraid: aborting-4813001 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813001:108[255:0], fw owner
megaraid: aborting-4813002 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813002:95[255:0], fw owner
megaraid: aborting-4813003 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813003:74[255:0], fw owner
megaraid: aborting-4813004 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813004:112[255:0], fw owner
megaraid: aborting-4813005 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813005:4[255:0], fw owner
megaraid: aborting-4813007 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813007:97[255:0], fw owner
megaraid: aborting-4813008 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813008:54[255:0], fw owner
megaraid: aborting-4813009 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813009:46[255:0], fw owner
megaraid: aborting-4813010 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813010:75[255:0], fw owner
megaraid: aborting-4813011 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813011:41[255:0], fw owner
megaraid: aborting-4813012 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813012:124[255:0], fw owner
megaraid: aborting-4813013 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813013:70[255:0], fw owner
megaraid: aborting-4813014 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813014:18[255:0], fw owner
megaraid: aborting-4813015 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813015:39[255:0], fw owner
megaraid: aborting-4813016 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813016:115[255:0], fw owner
megaraid: aborting-4813017 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813017:93[255:0], fw owner
megaraid: aborting-4813018 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813018:76[255:0], fw owner
megaraid: aborting-4813019 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813019:57[255:0], fw owner
megaraid: aborting-4813020 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813020:34[255:0], fw owner
megaraid: aborting-4813021 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813021:60[255:0], fw owner
megaraid: aborting-4813022 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813022:58[255:0], fw owner
megaraid: aborting-4813023 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813023:119[255:0], fw owner
megaraid: aborting-4813024 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813024:15[255:0], fw owner
megaraid: aborting-4813027 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813027:47[255:0], fw owner
megaraid: aborting-4813028 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813028:92[255:0], fw owner
megaraid: aborting-4813029 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813029:126[255:0], fw owner
megaraid: aborting-4813030 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813030:20[255:0], fw owner
megaraid: aborting-4813031 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813031:117[255:0], fw owner
megaraid: aborting-4813033 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813033:62[255:0], fw owner
megaraid: aborting-4813035 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813035:111[255:0], fw owner
megaraid: aborting-4813037 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813037:48[255:0], fw owner
megaraid: aborting-4813038 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813038:21[255:0], fw owner
megaraid: aborting-4813039 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813039:123[255:0], fw owner
megaraid: aborting-4813040 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813040:116[255:0], fw owner
megaraid: aborting-4813041 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813041:9[255:0], fw owner
megaraid: aborting-4813042 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813042:32[255:0], fw owner
megaraid: aborting-4813043 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813043:79[255:0], fw owner
megaraid: aborting-4813046 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813046:122[255:0], fw owner
megaraid: aborting-4813048 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813048:50[255:0], fw owner
megaraid: aborting-4813049 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813049:19[255:0], fw owner
megaraid: aborting-4813051 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813051:10[255:0], fw owner
megaraid: aborting-4813054 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813054:14[255:0], fw owner
megaraid: aborting-4813055 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813055:77[255:0], fw owner
megaraid: aborting-4813056 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813056:102[255:0], fw owner
megaraid: aborting-4813059 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813059:99[255:0], fw owner
megaraid: aborting-4813062 cmd=2a <c=1 t=0 l=0>
megaraid abort: 4813062:69[255:0], fw owner
megaraid: reseting the host...
megaraid: 64 outstanding commands. Max wait 180 sec
megaraid mbox: Wait for 64 commands to complete:180
megaraid mbox: reset sequence completed sucessfully
megaraid: aborting-5020448 cmd=2a <c=1 t=0 l=0>
megaraid abort: scsi cmd:5020448, do now own

Is this normal?

Controller is LSI megaraid 320-1

kernel is 2.6.3-rc3 patched with:
    1) ami_megaraid_series_475_pci_id.patch
     - Add pci id for AMI megaraid 169 (series 475):
       http://marc.theaimsgroup.com/?l=linux-kernel&m=109726192812932&w=2
    2) megaraid-2.20.4.0.patch
     -Fixes a data corruption bug:
       http://www.ussg.iu.edu/hypermail/linux/kernel/0409.3/1148.html

rathamahata@bo linux-2.6.9-rc3 $ grep Version drivers/scsi/megaraid/megaraid_mbox.c
 * Version      : v2.20.4 (September 27 2004)
rathamahata@bo linux-2.6.9-rc3 $
/dev/scsi/host0/bus1/target0/lun0/part1 on / type reiserfs (rw,noatime,nodiratime)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev type devfs (rw)
none on /dev/pts type devpts (rw)
/dev/scsi/host0/bus1/target1/lun0/part2 on /usr type reiserfs (rw)
/dev/scsi/host0/bus1/target1/lun0/part3 on /var/lib type reiserfs (rw)
/dev/scsi/host0/bus1/target1/lun0/part4 on /var/lib/mysql-innodb type reiserfs (rw,noatime,nodiratime,notail,data=writeback)
/dev/scsi/host0/bus1/target0/lun0/part2 on /var/www type reiserfs (rw)
tmpfs on /tmp type tmpfs (rw,size=384M)
rathamahata@bo linux-2.6.9-rc3 $
-- 
Sergey S. Kostyliov <rathamahata@ehouse.ru>
Jabber ID: rathamahata@jabber.org
