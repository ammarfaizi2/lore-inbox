Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275082AbRJVJpb>; Mon, 22 Oct 2001 05:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278462AbRJVJpO>; Mon, 22 Oct 2001 05:45:14 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:60365 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S278461AbRJVJo7>; Mon, 22 Oct 2001 05:44:59 -0400
From: Christoph Rohland <cr@sap.com>
To: Larry McVoy <lm@bitmover.com>, Alexander Viro <viro@math.psu.edu>
Cc: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
        ML-linux-kernel <linux-kernel@vger.kernel.org>,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com>
	<m33d4gjaoa.fsf@linux.local> <20011020171730.A28057@parallab.uib.no>
	<3BD28673.1060302@sap.com> <20011021093547.A24227@work.bitmover.com>
Organisation: SAP LinuxLab
Date: 22 Oct 2001 11:44:04 +0200
In-Reply-To: <20011021093547.A24227@work.bitmover.com>
Message-ID: <m3pu7gggbf.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Sun, 21 Oct 2001, Larry McVoy wrote:
> One of the engineers here has also seen this.  The root cause is
> that readdir() is returning a file multiple times.  We've seen it on
> tmpfs.  We also have seen in in NFS and had a workaround, the
> workaround depended that the file would be returned twice right next
> to each other and that's not the case in tmpfs.  wscott@bitmover.com
> can provide you with the details of his machine config, here's the
> mail he sent a while back about it:

tmpfs does not know anything about directory handling. It uses
generic_read_dir and dcache_readdir. So this must be a bug in the vfs
layer. Al, what do you say?

Greetings
		Christoph


