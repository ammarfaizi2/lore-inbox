Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266053AbSKTNDJ>; Wed, 20 Nov 2002 08:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbSKTNDJ>; Wed, 20 Nov 2002 08:03:09 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:38134 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S266053AbSKTNDJ>; Wed, 20 Nov 2002 08:03:09 -0500
Date: Wed, 20 Nov 2002 14:10:03 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [RFC/CFT] Separate obj/src dir
Message-ID: <20021120131003.GB16412@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <20021119201110.GA11192@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119201110.GA11192@mars.ravnborg.org>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 09:11:10PM +0100, Sam Ravnborg wrote:
> The kbuild shell script takes a verbatim copy of all Makefiles,
> all Kconfig files and all defconfigs. I did not even look into
> using symlinks, I was not sure how they work across NFS
> and the like.

But Kconfigs and defconfigs belong to the sources, don't they?

Suppose you have a main source tree and multiple objdirs with a
purpose to test different .configs. Now if you update the main
tree (including it's Kconfigs), objdirs are broken. The copies
of Kconfigs are obsoleted and maybe unrelated at all. Also makefiles.


