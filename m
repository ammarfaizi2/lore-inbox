Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbTBDCSc>; Mon, 3 Feb 2003 21:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBDCSc>; Mon, 3 Feb 2003 21:18:32 -0500
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:6366 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S267099AbTBDCSb>; Mon, 3 Feb 2003 21:18:31 -0500
Message-ID: <3E3F2501.9070009@lougher.demon.co.uk>
Date: Tue, 04 Feb 2003 02:27:13 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.9) Gecko/20020604
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Nicolas.Turro@sophia.inria.fr
Subject: Re: any compressed filesystem suggestion ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Turro wrote:
 >
 >Hi, we plan to build an NFS archive of old unix close accounts, and we 
are
 >looking for a compressed filesystem since size is more important than 
 >speed  for us. Our requirements are :
 >1- this fs must run on hardware raid (DAC960  Mylex AcceleRAID)
 >2- the archives files will be read-only for users, but we 
 >(administrators)
 >must be able to add files to the archives...
 >
 >Any recomendations ?

 >squashfs doesn't qualify because of 2 ...

Hi,

Append capability is the thing I'm currently adding to Squashfs.  Once 
finished, you'll be able to add new files/directories to the top level 
directory of a previously created filesystem.  As the mksquashfs program 
performs duplicate file checking against the files in the filesystem as 
well as the files being added, this means it will also work as a kind of 
incremental archiving filesystem.

An initial release should be ready in a week (or two depending on free 
time).

Phillip

 >what about e2compress ? http://www.alizt.com/index.html
 >
 >I've heard about block layer compression... is it applicable for us ?
 >Thanks for your advice...
 >
 >N. Turro

