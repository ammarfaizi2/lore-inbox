Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267672AbTAMMAt>; Mon, 13 Jan 2003 07:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTAMMAt>; Mon, 13 Jan 2003 07:00:49 -0500
Received: from pat.uio.no ([129.240.130.16]:23507 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267672AbTAMMAs>;
	Mon, 13 Jan 2003 07:00:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.44145.47417.934888@charged.uio.no>
Date: Mon, 13 Jan 2003 13:09:21 +0100
To: Paul Jakma <paulj@alphyra.ie>
Cc: Dax Kelson <Dax.Kelson@gurulabs.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: Re: [PATCH] Secure user authentication for NFS using RPCSEC_GSS
 [0/6]
In-Reply-To: <Pine.LNX.4.44.0301130745510.26185-100000@dunlop.admin.ie.alphyra.com>
References: <1042437391.1677.8.camel@thud>
	<Pine.LNX.4.44.0301130745510.26185-100000@dunlop.admin.ie.alphyra.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Paul Jakma <paulj@alphyra.ie> writes:

     > On 12 Jan 2003, Dax Kelson wrote:
    >> Standard NFS security/authentication sucks rocks. Without this
    >> NFS home directory servers are just waiting to be ransacked by
    >> a rouge (or compromised) root user on a client machine.

     > AIUI, A root user still can. The users krbv5 credentials will
     > generally have been cached to storage. (though i suppose one
     > could mount that storage via NFS and use root_squash, but
     > that's little protection.).

Once the root account has been compromised, it is 'Game Over' no
matter what you do. Kerberos or no Kerberos, the simplest way to steal
your identity is simply for the attacker to listen in on your tty
while you are typing your password.

The RPCSEC_GSS security model is not meant to protect you against root
monitoring. It is meant to prevent some third party (on another
machine for instance) from spoofing RPC requests in you name (==
strong authentication), intercepting valid RPC requests and modifying
the payload (== cryptographic data integrity checking), or listening
in on the client/server communication (== data privacy).

Cheers,
  Trond
