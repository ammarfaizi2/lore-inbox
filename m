Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279805AbRKMXCm>; Tue, 13 Nov 2001 18:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279808AbRKMXCc>; Tue, 13 Nov 2001 18:02:32 -0500
Received: from zero.tech9.net ([209.61.188.187]:6404 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S279805AbRKMXCZ>;
	Tue, 13 Nov 2001 18:02:25 -0500
Subject: Re: [PATCH] search_one_table()
From: Robert Love <rml@tech9.net>
To: Per Persson <per.persson@gnosjo.pp.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBJMOHILCIIKFHCBHAIEOECAAA.per.persson@gnosjo.pp.se>
In-Reply-To: <NDBBJMOHILCIIKFHCBHAIEOECAAA.per.persson@gnosjo.pp.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 13 Nov 2001 18:02:21 -0500
Message-Id: <1005692549.926.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-13 at 17:32, Per Persson wrote:
> -		mid = (last - first) / 2 + first;
> +		mid = (last + first) / 2

Ehh, maybe its my scientific computer side talking, but your change will
overflow.  Adding two addresses can certainly return an address larger
than 0xffffffff, so you see formulas like the above.

	Robert Love

