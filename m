Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWEKAWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWEKAWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWEKAWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:22:32 -0400
Received: from are.twiddle.net ([64.81.246.98]:50322 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S965106AbWEKAWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:22:31 -0400
Date: Wed, 10 May 2006 17:22:17 -0700
From: Richard Henderson <rth@twiddle.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
       linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060511002217.GA31481@twiddle.net>
Mail-Followup-To: Segher Boessenkool <segher@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	"David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com> <20060510154702.GA28938@twiddle.net> <20060510.124003.04457042.davem@davemloft.net> <17506.21908.857189.645889@cargo.ozlabs.ibm.com> <49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 01:17:50AM +0200, Segher Boessenkool wrote:
> Would an asm clobber of GPR13 in the schedule routines (or a wrapper
> for them, or whatever) work?

No.  The address is cse'd symbolically long before the r13
reference is exposed.


r~
