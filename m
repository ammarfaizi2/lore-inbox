Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279694AbRJYHLq>; Thu, 25 Oct 2001 03:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279700AbRJYHLh>; Thu, 25 Oct 2001 03:11:37 -0400
Received: from are.twiddle.net ([64.81.246.98]:17586 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S279694AbRJYHLW>;
	Thu, 25 Oct 2001 03:11:22 -0400
Date: Thu, 25 Oct 2001 00:11:50 -0700
From: Richard Henderson <rth@twiddle.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Hawkes <hawkes@oss.sgi.com>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
Message-ID: <20011025001150.A8776@twiddle.net>
Mail-Followup-To: Benjamin LaHaise <bcrl@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Hawkes <hawkes@oss.sgi.com>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
In-Reply-To: <20011022161527.K23213@redhat.com> <E15vlx2-0003HO-00@the-village.bc.nu> <20011022165157.M23213@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011022165157.M23213@redhat.com>; from bcrl@redhat.com on Mon, Oct 22, 2001 at 04:51:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2001 at 04:51:57PM -0400, Benjamin LaHaise wrote:
> Which of the following is more readable:
[...]

Or (4):

	"btsl $0, %0		\n\
1:				\n\
	.section .text.lock	\n\
2:	cmpl $0,%0		\n\
	bne 2b			\n\
	jmpl 1b			\n\
	.previous"



r~
