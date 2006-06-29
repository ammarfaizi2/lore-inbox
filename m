Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWF2MbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWF2MbH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 08:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWF2MbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 08:31:07 -0400
Received: from pool-72-66-192-207.ronkva.east.verizon.net ([72.66.192.207]:50118
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751876AbWF2MbG (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 08:31:06 -0400
Message-Id: <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Paul Jackson <pj@sgi.com>
Cc: Jay Lan <jlan@engr.sgi.com>, akpm@osdl.org, nagar@watson.ibm.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
In-Reply-To: Your message of "Thu, 29 Jun 2006 01:40:50 PDT."
             <20060629014050.d3bf0be4.pj@sgi.com>
From: Valdis.Kletnieks@vt.edu
References: <44892610.6040001@watson.ibm.com> <20060609010057.e454a14f.akpm@osdl.org> <448952C2.1060708@in.ibm.com> <20060609042129.ae97018c.akpm@osdl.org> <4489EE7C.3080007@watson.ibm.com> <449999D1.7000403@engr.sgi.com> <44999A98.8030406@engr.sgi.com> <44999F5A.2080809@watson.ibm.com> <4499D7CD.1020303@engr.sgi.com> <449C2181.6000007@watson.ibm.com> <20060623141926.b28a5fc0.akpm@osdl.org> <449C6620.1020203@engr.sgi.com> <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com> <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com> <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org> <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org> <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org> <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org> <44A2FC72.9090407@engr.sgi.com>
            <20060629014050.d3bf0be4.pj@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151584242_2887P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 08:30:42 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151584242_2887P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Jun 2006 01:40:50 PDT, Paul Jackson said:

> Jay - what happens if we have 1024 CPUs (the current default config
> for ia64/sn2)?
> 
> My naive expectation would be that the rate of exits/sec would go up as
> the number of CPUs. In other words, I'd expect the exits/sec/CPU to be
> a rough constant, slowly increasing over the years as the CPU clock
> rate goes up.

You're probably correct on that model. However, it all depends on the actual
workload. Are people who actually have large-CPU (>256) systems actually
running fork()-heavy things like webservers on them, or are they running things
like database servers and computations, which tend to have persistent
processes?

Of course, I'm biased by my environment - the big Mac cluster and 2 larger SGI
boxes we have quite likely spend hours at a time where the exit/sec for the
entire image is in the single and low double digits, and the per-cpu value
is down in the noise.  But they're pure machoflops boxes....


--==_Exmh_1151584242_2887P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEo8fycC3lWbTT17ARAu1DAJ0S04toGhbkG2QXHpwBZhC0bPuFJwCaAwM/
5xhnDpvakY+tjGsx3maH46o=
=Bemd
-----END PGP SIGNATURE-----

--==_Exmh_1151584242_2887P--
