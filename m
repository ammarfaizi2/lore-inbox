Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129309AbRBTJot>; Tue, 20 Feb 2001 04:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129191AbRBTJok>; Tue, 20 Feb 2001 04:44:40 -0500
Received: from pat.uio.no ([129.240.130.16]:18838 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S129309AbRBTJog>;
	Tue, 20 Feb 2001 04:44:36 -0500
To: Roman Zippel <zippel@fh-brandenburg.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        dek_ml@konerding.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net, mason@suse.com
Subject: Re: [NFS] Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: <Pine.GSO.4.10.10102200330330.25095-100000@zeus.fh-brandenburg.de>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Content-Type: text/plain; charset=US-ASCII
Date: 20 Feb 2001 10:44:07 +0100
In-Reply-To: Roman Zippel's message of "Tue, 20 Feb 2001 03:38:32 +0100 (MET)"
Message-ID: <shslmr11yfs.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Roman Zippel <zippel@fh-brandenburg.de> writes:

     > Hi, On Tue, 20 Feb 2001, Neil Brown wrote:

    >> 2/ lookup("..").

     > A small question: Why exactly is this needed?

Short answer: the existence of 'rename' makes it necessary, since it
means that the directory path is volatile as far as the client is
concerned.

IIRC several NFS implementations (not Linux though) rely on being able
to walk back up the directory tree in order to discover the path at
any given moment.

Under Linux, our reliance on dentries doesn't allow for directory
paths to be volatile, so we don't support it. Instead we end up having
to support aliased directories.

Cheers,
  Trond
