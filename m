Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268317AbUH2V0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268317AbUH2V0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268326AbUH2V0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:26:49 -0400
Received: from holomorphy.com ([207.189.100.168]:41136 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268317AbUH2V0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:26:40 -0400
Date: Sun, 29 Aug 2004 14:26:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
       Alessandro Rubini <rubini@ipvvis.unipv.it>
Subject: Re: [util-linux] readprofile ignores the last element in /proc/profile
Message-ID: <20040829212635.GY5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	mita akinobu <amgta@yacht.ocn.ne.jp>, linux-kernel@vger.kernel.org,
	Alessandro Rubini <rubini@ipvvis.unipv.it>
References: <200408250022.09878.amgta@yacht.ocn.ne.jp> <20040829162252.GG5492@holomorphy.com> <20040829184114.GS5492@holomorphy.com> <20040829192617.GB24937@apps.cwi.nl> <20040829212350.GX5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829212350.GX5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 02:23:50PM -0700, William Lee Irwin III wrote:
> It probably qualifies as impolite. I suppose a better way of going
> about this would be saying that the code has accumulated some cruft,
> and then describing the differences in greater detail.
> The removal of the multiplier resetting is an oversight; I rarely
> use the feature myself, but upon closer examination, the multiplier
> accepted by write_profile() is not ASCII. I also question the role of a
> profile report extraction utility in alterations of profiling state.
> The removal of the reset feature is once again intentional as this
> can be done by echo > /proc/profile.
> The removal of the individual bin count reporting is intentional, but
> not a very nice removal, as it's a useful feature and definitely not a
> misfeature. The format of the histogram reporting is, however, not very
> useful as sort(1) etc. don't easily interoperate with it. This should
> be put back for serious use.

Oh, the removal of the reversed byte order detection was also very
intentional as that appears to frequently go wrong. I'd prefer an
explicit option to support cross-endianness profiling.


-- wli
