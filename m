Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267348AbSLRTC3>; Wed, 18 Dec 2002 14:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267350AbSLRTC2>; Wed, 18 Dec 2002 14:02:28 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:10155 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267348AbSLRTCE>; Wed, 18 Dec 2002 14:02:04 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15872.51211.294993.789788@laputa.namesys.com>
Date: Wed, 18 Dec 2002 22:10:03 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Cliff White <cliffw@osdl.org>
Cc: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: [Benchmark] AIM9 results 
In-Reply-To: <200212181847.gBIIlhO26530@mail.osdl.org>
References: <reiser@namesys.com>
	<3DFE690D.7000602@namesys.com>
	<200212181847.gBIIlhO26530@mail.osdl.org>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White writes:
 > > Andrew Morton wrote:
 > > 
 > > >Andrew Morton wrote:
 > > >  
 > > >
 > > >>Hans Reiser wrote:
 > > >>    
 > > >>
 > > >>>Andrew and Chris, are these changes in performance definitely due to VM
 > > >>>changes (and not some difference I am not thinking of between 2.5 and
 > > >>>2.4 reiserfs code)?
 > > >>>
 > > >>>      
 > > >>>
 > > >>aim9 is just doing
 > > >>
 > > >>        for (lots)
 > > >>                close(creat(filename))
 > > >>    
 > > >>
 > > >                  unlink(filename);	/* of course */
 > > >
 > > >
 > > >  
 > > >
 > > Oh, commercial fs vendors must really love tuning for this benchmark.... 
 > > sigh....
 > > 
 > Ya, we think the AIM stuff is getting a little old. The basic idea is fine, but
 > many of the tests do _very little work.  We (OSDL) would like to re-do 
 > AIM9+7 and make it more useful. We'd love to have some input from everyone....
 > For example, how big a file should we create for a real creat() test ?

Probably it should be variable. You may take a look at the way "mongo"
script (http://www.namesys.com/benchmarks/mongo.tar.gz) used to
benchmark reiserfs calculates size of file
(reiser_fract_tree.c:determine_size() function). Hmm, I remember putting
long comment for this function, but now it is gone...

 > cliffw
 > 
 > > Hans
 > > 

Nikita.
