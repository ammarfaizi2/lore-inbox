Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274884AbTGaVim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTGaViE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:38:04 -0400
Received: from holomorphy.com ([66.224.33.161]:36057 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S274875AbTGaVhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:37:35 -0400
Date: Thu, 31 Jul 2003 14:38:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Szonyi Calin <sony@etc.utt.ro>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O11int for interactivity
Message-ID: <20030731213846.GF15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Szonyi Calin <sony@etc.utt.ro>, kernel@kolivas.org,
	linux-kernel@vger.kernel.org
References: <200307301038.49869.kernel@kolivas.org> <200307301055.23950.kernel@kolivas.org> <200307301108.53904.kernel@kolivas.org> <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 04:55:54PM +0300, Szonyi Calin wrote:
> A little bit better than O10 but mplayer still skips frames while
> doind a make bzImage in the background

Could you do the following during an mp3 skipping test please:

vmstat 1 | tee -a vmstat.log

n=1; while true; do /usr/sbin/readprofile -n -m /boot/System.map-`uname -r` | sort -k 2,2 > profile.log.$n ; n=$(($n + 1)) ; sleep 1 ; done

If you could stop both the vmstat and the readprofile loop shortly
after the skip (not _too_ shortly, at least 1 second after it) I'd be
much obliged.


--- wli
