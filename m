Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <161080-8100>; Mon, 18 Jan 1999 12:32:43 -0500
Received: by vger.rutgers.edu id <160608-8093>; Mon, 18 Jan 1999 12:32:28 -0500
Received: from gate.guardian.no ([195.1.254.2]:61393 "HELO lucifer.guardian.no" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <161074-8093>; Mon, 18 Jan 1999 12:30:16 -0500
Message-ID: <19990118183227.B24626@lucifer.guardian.no>
Date: Mon, 18 Jan 1999 18:32:27 +0100
From: Alexander Kjeldaas <astor@guardian.no>
To: linux-kernel@vger.rutgers.edu
Subject: International kernel patch v2.2.0-pre7.4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
Sender: owner-linux-kernel@vger.rutgers.edu

International kernel patch 2.2.0-pre7.4 is available.  The idea of the
patch is to collect all crypto patches so that using crypto in the
kernel will be easier than today.
  
The patch is available from:

ftp://ftp.kerneli.org/pub/linux/kerneli/v2.1/patch-int-2.2.0-pre7.4.gz

SUMMARY: Relative to the previously announced version (pre4.1), this
release contains faster/updated MARS/RC6/Serpent ciphers, better
module support, a lot of testvectors for some ciphers, a general
test-program for the crypto-library, and an updated ENskip patch.

NOTE: Please treat this patch as alpha software. 

TODO:
 	* Endian-issues haven't been sorted out.  If some big-endian
          people would try crypto/testing/testcip and the different
          crypto/testing/test.<cipher> scripts I'd be happy.  There
          still are endian issues on i386.

	* I have a report on kmod and the des cipher not working with
          this patch.

	* /proc support

	* Compound transforms - Wassenaar-compatibility(tm).  My
          thoughts on this issue which amounts to putting a
          specification language for transforms and a parser in the
          kernel.  The BNF-grammar for this language is ~6 lines.

	* Create the necessary infrastructure for assembly-language
          ciphers.

	* Write 4-way IDEA cipher for MMX.  IDEA is ideal for MMX and
          a 4-way IDEA cipher using MMX would blow away the other
          ciphers we have and at the same time be a well-known and
          well-tested algorithm.

	* Get CIPE to use the crypto library.

CHANGELOG since pre4.1:

1999-01-18  Alexander Kjeldaas  <astor@guardian.no>

        * International kernel patch 2.2.0-pre7.4 released.

        * Added cbc-mode to cast256 cipher.

        * Removed spam on unload from crypto modules.

        * Added updated ENskip patches from Frank Bernard's web site:
        http://www.linux-firewall.de/enskip/

        * International kernel patch 2.2.0-pre7.3 released.

        * Added missing cleanup_module to DES, Blowfish and IDEA ciphers.

        * International kernel patch 2.2.0-pre7.2 released.

        * Cleanup in drivers/block/Config.in.  It was possible to create
        an invalid .config file. 

        * Minor crypto/api.c cleanup.

1999-01-17  Alexander Kjeldaas  <astor@guardian.no>

        * International kernel patch 2.2.0-pre7.1 released.

        * Added testcip.c - a general purpose cipher test program.  Added
        test-vector scripts for Blowfish, DES, Mars, and Serpent. 

        * Naming error left users unable to compile loop_gen unless it was
        compiled as a module.

        * Updated Serpent implementation.  Sam Simpson has been running a
        background task on a cluster of high performance servers.  After a
        search involving around 1000 machine hours improved sboxes were
        found.

        * Updated RC6 implementation.  Supposedly faster.

        * Updated MARS implementation.  Fixes a bug in mars_set_key.

1999-01-07  Alexander Kjeldaas  <astor@guardian.no>

        * International kernel patch 2.2.0-pre5.1 released.
        * Merged with vanilla 2.2.0-pre5

1999-01-05  Herbert Valerio Riedel <hvr@hvrlab.ml.org>

        * APX fixes.


On the ftp-site, the directory /pub/linux/kernel is a normal
kernel-mirror while /pub/linux/kerneli is a kernel-mirror plus the
international kernel patch.  You should find all utilities needed for
using crypto in the kernel in /pub/linux/kerneli/net-source/.

astor

-- 
 Alexander Kjeldaas, Guardian Networks AS, Trondheim, Norway
 http://www.guardian.no/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
