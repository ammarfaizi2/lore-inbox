Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUH3Kxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUH3Kxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 06:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUH3Kxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 06:53:43 -0400
Received: from holomorphy.com ([207.189.100.168]:13236 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267651AbUH3Kxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 06:53:42 -0400
Date: Mon, 30 Aug 2004 03:53:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040830105322.GE5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paulo Marques <pmarques@grupopie.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040828195647.GP5492@holomorphy.com> <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube> <4133020F.1060306@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4133020F.1060306@grupopie.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>> This is crummy. It's done for wchan, since that is so horribly
>> expensive, but I'm not liking the larger race condition window.
>> Remember that PIDs get reused. There isn't a generation counter
>> or UUID that can be checked.

On Mon, Aug 30, 2004 at 11:31:43AM +0100, Paulo Marques wrote:
> I just wanted to call your attention to the kallsyms speedup patch that 
> is now on the -mm tree.
> It should improve wchan speed. My benchmarks for kallsyms_lookup (the 
> function that was responsible for the wchan time) went from 1340us to 0.5us.
> So maybe this is enough not to make wchan a special case anymore...

This seems to go wrong on big-endian machines; any chance you could look
over your stuff and try to figure out what endianness issues it may have?


-- wli
