Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263390AbVGAQqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbVGAQqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263391AbVGAQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:46:13 -0400
Received: from main.gmane.org ([80.91.229.2]:63622 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263390AbVGAQqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:46:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: FUSE merging?
Date: Fri, 01 Jul 2005 18:45:28 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.01.16.45.25.992688@smurf.noris.de>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu> <20050630235059.0b7be3de.akpm@osdl.org> <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu> <20050701001439.63987939.akpm@osdl.org> <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu> <20050701010229.4214f04e.akpm@osdl.org> <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu> <20050701042955.39bf46ef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> Sorry, but I'm not buying it.  I still don't see a solid reason why all
> this could not be done with nfs/v9fs, some kernel tweaks and the rest in
> userspace.

Let's forget about NFS here. It's stateless. You don't want a wholly
stateless layer between two stateful instances; the fact that it works for
a disk-based NFS server isn't proof that it'd work for gmailfs or sshfs.

There are a lot of FUSE server implementations out there already.
You want all of them to rewrite their code for v9fs?

I admit that I don't know zilch about how difficult it is to write a v9fs
server (is there sane sample code / a support library?) or how much
overhead such a server would incur or how safe it'd be to run a
user-controlled server on the same machine as the mountpoint.
The point is that the FUSE people already cover all these points,
thus: unless there's a major technical problem with it that v9fs solves
better, I'd advocate to include it.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Magpie, n.:
	A bird whose thievish disposition suggested to someone that it
	might be taught to talk.
		-- Ambrose Bierce, "The Devil's Dictionary"


