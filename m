Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281102AbRKTW5J>; Tue, 20 Nov 2001 17:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281103AbRKTW47>; Tue, 20 Nov 2001 17:56:59 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:11831 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281102AbRKTW4r>; Tue, 20 Nov 2001 17:56:47 -0500
Date: Tue, 20 Nov 2001 17:56:46 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rick Ellis <ellis@ftel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sk_buff alignments
Message-ID: <20011120175645.B21992@redhat.com>
In-Reply-To: <200111202134.fAKLYtT23465@spinics.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200111202134.fAKLYtT23465@spinics.net>; from ellis@ftel.net on Tue, Nov 20, 2001 at 01:34:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 01:34:55PM -0800, Rick Ellis wrote:
> The Dp83820 gigabit ethernet chip requires its buffers to be
> on 64 bit boundaries.  Does this mean I have to copy the
> packet?

ns83820.c copies packets to meet the alignment issues that the networking 
stack has on non-x86 platforms.  Tx packets do not need to be copied.

		-ben
-- 
Fish.
