Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262111AbSJDPtL>; Fri, 4 Oct 2002 11:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262113AbSJDPtL>; Fri, 4 Oct 2002 11:49:11 -0400
Received: from pat.uio.no ([129.240.130.16]:48005 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262111AbSJDPsK>;
	Fri, 4 Oct 2002 11:48:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15773.47490.564575.814249@charged.uio.no>
Date: Fri, 4 Oct 2002 17:53:38 +0200
To: David Howells <dhowells@cambridge.redhat.com>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS filesystem for Linux (2/2) 
In-Reply-To: <27308.1033745758@warthog.cambridge.redhat.com>
References: <trond.myklebust@fys.uio.no>
	<shsheg2i7x2.fsf@charged.uio.no>
	<27308.1033745758@warthog.cambridge.redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Howells <dhowells@cambridge.redhat.com> writes:

    >> NFSv4 does indeed require the full kerberos encryption stuff in
    >> the kernel. The RFC specifies that krb5 support is a minimum
    >> requirement, and we will expect to have that in 2.6 (or 3.0 or
    >> whatever it's called these days...)

     > Might this be something I can make use of for my AFS filesystem
     > too?

Possibly. Our intention is to integrate the RPCSEC_GSS security
protocol (see RFC2203) into the sunrpc code, then use krb5 as one of
the authentication flavours.

Whereas I doubt that AFS uses RPCSEC_GSS, I believe that the kerberos
code itself (+ upcall mechanism for getting user tokens etc.) could be
reused by you. I presume that you would make use of the sunrpc code
too?

Cheers,
  Trond
