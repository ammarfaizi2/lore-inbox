Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281343AbRKPMZj>; Fri, 16 Nov 2001 07:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281351AbRKPMZa>; Fri, 16 Nov 2001 07:25:30 -0500
Received: from mons.uio.no ([129.240.130.14]:64761 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S281343AbRKPMZR>;
	Fri, 16 Nov 2001 07:25:17 -0500
To: miquels@cistron-office.nl (Miquel van Smoorenburg)
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs problem: hp|aix-server --- linux 2.4.15pre5 client
In-Reply-To: <20011115222920.A9929@ludwig2.science-computing.de>
	<shssnbf37td.fsf@charged.uio.no>
	<15348.63313.961267.735216@stderr.science-computing.de>
	<15348.64613.465429.628445@charged.uio.no>
	<9t2v62$7g0$1@ncc1701.cistron.net>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Nov 2001 13:24:51 +0100
In-Reply-To: <9t2v62$7g0$1@ncc1701.cistron.net>
Message-ID: <shsk7wqlx7w.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Miquel van Smoorenburg <miquels@cistron-office.nl> writes:

    >> That's because the HP is returning a READDIR reply that is
    >> larger than the buffer size we specified. When this happens, we
    >> truncate the reply at the last valid record before the buffer
    >> overflow, and print out the above message.

     > Shouldn't the message then be "NFS: too large packet in readdir
     > reply!" ?

8) Or 'NFS: truncated packet in readdir reply!', since that is what
NFS actually is returned by the RPC layer.

When we are sure that the code is stable, the whole message can go. It
is really just reporting a server error. As long as we handle it
correctly, there should be no need to churn out all these printks.

Cheers,
  Trond
