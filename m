Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270831AbTHKCEL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTHKCEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:04:10 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:61353 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S270831AbTHKCEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:04:06 -0400
Date: Sun, 10 Aug 2003 19:03:38 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: henryy@karajishi.org
Subject: [Bug 1075] New: corrupt dirctory when mounting smbfs from a WinXP box with unicode option
Message-ID: <65080000.1060567418@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1075

           Summary: corrupt dirctory when mounting smbfs from a WinXP box
                    with unicode option
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: henryy@karajishi.org


Distribution: Gentoo
Hardware Environment: Pentium3 735Mhz (OCed)
Software Environment: 

 Local: default fs codepage utf8, gcc 3.2.3, samba_3_0_20030720

 Remote: WinXP SP1, default Language English(Canada) codepage 850

Problem Description: 

When mounting a directory on the WinXP Box using unicode,codepage=unicode 
option, if a directory contain ertain combination of filenames, ls will fail to 
show all the files.

The problem does not exist if the remote machine is Linux with 
samba_3_0_20030720, unicode enabled. (tested on localhost)

The filenames that cause the problem are all ASCII compatible.

It is very hard to isolate which filename combos can cause the problem.

Steps to reproduce:

on Windows XP, extract the included files to a directory and put it on share:

begin 644 gash.tar.gz
M'XL(`'V:-C\``^V=86_;-A"&_5/8+T,"S!HIB=+Z,?.<H9B;;G/6KA@&0HF4
M6*TM&99B._]^LF)#79O2%FV=A.Y]@#I-4X!)'AW).Y[D^R";_-!K%LY=[ONR
M^%CR]%'8N\^?_LWWA91"%E_H<<$]1_28;/C[*GG(\F#!6&^1IKGN_ZTF432E
M^(9HN=_X_S5-/L0?8Y6DZI?B<_53-)TJ+M12GD5AG$?A]RI_G$=9E)];61;4
M':/PR3W/W>O?]AS7E85_6SA^X9\W\0-_#OQ_W?_O`[6TK7RM_<7LI[9_X7D2
M_DDH_4=S[EC%[R'/&AFCOG_;E0[\4U#ZW[S<%#'/A14L3W\-U/?OV![BGX32
M__O"?;IBHSB)K`_S^U./8>#?Q?Q/@W[_)TRV>U]@L/[;C@O_%.C]V^WYE_!/
M@=Z_TYY_#_XIT/MWV_/OPS\%&O^V>BK^J/'@N,N@OG]?.C;\4Z#Q[ZIA<IN&
MQ05P\ZC&T?IQD,YF01*F:LF=(E&,#QVC?OW/$0+Y/PF[^H^P9G-G\Z>!,0SJ
M/U)P^*>@]'\5K9X"GTNU"%;JS'/YVOV1GZN_!S][+\6%/?RG3L!_AL'Z[]O(
M_TG0[O^^/O_+QN=_K/\D&/KWL/Y_&^S6?[=KYS^H_Y'P:?RS)&6;^&>;^'_!
MAG/&)3LK-@3G1RS^/:/U'_L_(C3SOZ.9_VWU[O7+0Z\*@_G?XZC_DJ#UW^;Y
M#^J_).C]MWC^@_HO"7K_[9W_N%C_22C])]%*;?XB5?`0QJFZB]=1>+IB8'W_
MTO6P_I.PR_]DU_(_^">A]#]*@_"WZ<-]G`S75C@]]8]IT/_E(?^GX?#S7RO(
M#*>'^OD?=P3V?R28YO^-UW]Q_D."6?W_\M(:7[X]=`P#_QS[?QJ,_3<<_^C_
MIT'C7[99_T/\TZ#WWU[]ST7\DU#Z/[M(LTE\_HG\UT&<J.MHG:M^D0@L_:.N
M`X/^3\=#_P<)I?]5L)AGD^*E@>2_9Y3_.P[F?Q)T^?^I;@8UJ/]ZZ/^F09?_
M']?U46'B'_V?-.SQWU[\H_^/!&W]M\W^#YS_D*#WWV+_!_I_2-#[;_'^7YS_
MD*#WW][]OZC_T:#W+U'_V_$M^]_6_ZKF?W81AFERFMV?T?[?P?DO#3K_I]G]
M&?I'_8>$K?_^D'W'ME?!LW<#O6!]-AJ^'8X8%TN?7;ZZNAAM7\?#/UZ]^7,\
M>L^NWKQ[[I*I?_[K<H[\GX3J_O^.]7]B_B>A]+^XR<*/S9S];##Q;R/_)T&[
M_]]S_[^5IXM%E.Q].K#!_.]QY/\DE/X'Z?R1I7>LH3X`@_Y?S\7^CP3#^&_^
M^4]8_TDPGO\;[?^U?1_Q3\(QZ_^A8^#Y+]UEE__97<O_$/\D:)__N!0G:0$R
M.O_#^0\)^_SC_'?+_])_B_W_B'\2]/Y;?/X'\C\2JOK_]5_7#8U1W[]`_D?$
M?Y[_W-`8!OM_CO-?&BK_^6S>T!@&_I'_$U'Y7][>-32&2?SC_3]IJ/RO9E%#
M8YC$/_H_:*CJ?QU;_^&?A,I_Q^9_[/](J-[_MV/QC^>_D5#Y[]C^'_?_D5#Y
M[]C\C_6?A.K]/SKF'_,_"=7S?SOF'_,_"36>_QK&=V97B$'_IXOS'QI*_YN7
MF\(Y%U^V>M7J]'L>H_?_P_DO"7O]BWX_C!?1;9Y-TI79$V'JQ[^P,?\#````
3`````````'`\_P+@'/B8`*``````
`
end

on local machine: mount the share as follows:

smbmount <sharename> <mount point> -o unicode,codepage=unicode

type ls:

only about 20 files will show up.


