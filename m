Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSDUJ6T>; Sun, 21 Apr 2002 05:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312031AbSDUJ6S>; Sun, 21 Apr 2002 05:58:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:3849 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S311211AbSDUJ6S>; Sun, 21 Apr 2002 05:58:18 -0400
Message-Id: <200204210955.g3L9tUX08427@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: /proc/stat weirdness
Date: Sun, 21 Apr 2002 12:58:41 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was curious about top showing unwieldy numbers for idle%
(start top, hold down [space] and you'll see).

top reads /proc/stat in order to get these percents.
A little script which cats /proc/stat continually
and greps for 'cpu  ' yield:
cpu  39778 0 46829 337191
cpu  39778 0 46831 337192
cpu  39778 0 46833 337193
cpu  39778 0 46834 337194
cpu  39778 0 46835 337195
cpu  39778 0 46836 337196
cpu  39778 0 46838 337197 <<<
cpu  39778 0 46840 337196 <<< 
cpu  39780 0 46840 337198
cpu  39780 0 46842 337199
cpu  39780 0 46843 337201
cpu  39782 0 46844 337201
cpu  39782 0 46846 337201
cpu  39782 0 46848 337201
cpu  39782 0 46849 337202
cpu  39782 0 46849 337204
cpu  39782 0 46850 337205
cpu  39782 0 46852 337205
cpu  39782 0 46853 337206
cpu  39783 0 46853 337207
cpu  39783 0 46855 337207 <<<
cpu  39784 0 46856 337206 <<<
...

Kernel: 2.4.18-pre6
--
vda
