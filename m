Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVHQPLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVHQPLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 11:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVHQPLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 11:11:50 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:47178 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751128AbVHQPLu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 11:11:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wjwl7dQkYmkcFOclOqG4mrDiRpU1vBJlCfqeCV7Lrr1AXkTnGxaMO2SL110mbI9Iy5rt85AMGfRcLPtS/DGrD83u9i657POQYc4yVSgZAianPAKL1lwhqivaf/HGWH1Yn4s49tZgsC5axjYZ+zNM1z3sCHRjbcWA9r1qRWWdqtU=
Message-ID: <86802c44050817081153e30fe8@mail.gmail.com>
Date: Wed, 17 Aug 2005 08:11:48 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Jeff Mahoney <jeffm@suse.com>
Subject: Re: 2.6.12.3 clock drifting twice too fast (amd64)
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       jerome lacoste <jerome.lacoste@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Marie-Helene Lacoste <manies@tele2.fr>
In-Reply-To: <430339AA.2050007@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a2cf1f6050816031011590972@mail.gmail.com>
	 <Pine.LNX.4.62.0508161103360.7101@schroedinger.engr.sgi.com>
	 <430273F3.2000204@suse.com>
	 <86802c4405081623483284908e@mail.gmail.com>
	 <430339AA.2050007@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks

YH

On 8/17/05, Jeff Mahoney <jeffm@suse.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> fyhlu wrote:
> > Me too. If use latest kernel mouse is dead.
> >
> > By the way, did you solve the battery problem in Linux. "Can not read
> > battery status"
> 
> Yes. It's a problem with the DSDT. Install pmtools (for iasl - the acpi
> compiler) and grab
> ftp://ftp.suse.com/pub/people/jeffm/acpi/Acer_Ferrari_4000.DSDT.asl
> 
> You'll need to enable ACPI_CUSTOM_DSDT to do use it, or if you're on a
> SUSE system (sorry, I don't know if/which other systems support this),
> you can enable a new DSDT by including it in the init{rd,ramfs}. (See
> the -a option to mkinitrd)
> 
> The attached script will turn your AML file into a character array for
> use with ACPI_CUSTOM_DSDT.
> 
> There are other issues that need to be worked out in the DSDT, and since
> I'm not an ACPI guru (or even anything beyond a casual observer), this
> may take some time. Specifically, I get this ...
> nsxfeval-0251 [06] acpi_evaluate_object  : Handle is NULL and Pathname
> is relative
> ... for several paths, which a bit of debugging tells me is _PR[0-3]
> from the root node. Unfortunately, there is no instance of _PR[0-3] in
> the DSDT asl file.
> 
> - -Jeff
> 
> - --
> Jeff Mahoney
> SuSE Labs
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.0 (GNU/Linux)
> 
> iD8DBQFDAzmpLPWxlyuTD7IRAhupAJ9rAXNZAX3tzHxCzwYuPUE1LO/ivwCghvTT
> 8uaZtso9gnu9FGk8Imjk94k=
> =Iesw
> -----END PGP SIGNATURE-----
> 
> 
>
