Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTDQTpL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbTDQTpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:45:11 -0400
Received: from smtp0.libero.it ([193.70.192.33]:43409 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S261921AbTDQTpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:45:10 -0400
Date: Thu, 17 Apr 2003 21:56:48 +0200
From: "Antonio G. - Geotronix" <antonio@sunstone.it>
To: linux-kernel@vger.kernel.org
Subject: understanding and tuning the bonnie++ benchmarks.
Message-ID: <20030417195648.GB1723@geolandia.home>
Reply-To: antonio@sunstone.it
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux gaia.geolandia.home 2.4.19omosix i686
X-Disclaimer: Linux - The choice for freedom!
User-Agent: Mutt 1.4i (2002-05-29)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I've tried running a few bonnie++ benchmarks but I'm not understaning
how to tune the options. Nor can I figure out much form the output
because I don't understand what the options do... 
I went to the programs homepage but theres no info on this.

This is the string I used to measure my single HD throughput. This
because I want to compare it with the RAID system I will soon implement.

bonnie++ -d /mnt/download/hd_tests/ -s:1024:32k -m Gaia -r 512 -x 2 -u
antonio -f | bon_csv2txt

And this is the output:

Version  1.02b      ------Sequential Output------ --Sequential Input- --Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
Gaia         1G:32k           26895  41 10177  13           25450  16 145.5   3
Gaia         1G:32k           26636  42  9849  12           25920  17 146.4   3
                    ------Sequential Create------ --------Random Create--------
                    -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
Gaia             16   340  97 +++++ +++ 16450  79   340  97 +++++ +++  1861  96
Gaia             16   267  77 +++++ +++ 12301  62   240  69 +++++ +++  1339  69

----------------end of first test-------------------

If my filesys is ext3 with 4K blocks must I use a 4K chunk-size? Is this
what the chunk-size is for?? 
Why is the "sequential create --> read" empty? I would like to
understand how fast is my HD in reading but can't get it from the
above...

Would be greatfull if someone could help me with this stuff. A nice link
to some www page would do fine. I tried with google but can't find much
that is helpfull.

Thanks
