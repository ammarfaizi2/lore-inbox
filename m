Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRDVFsK>; Sun, 22 Apr 2001 01:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135221AbRDVFsA>; Sun, 22 Apr 2001 01:48:00 -0400
Received: from cx879306-a.pv1.ca.home.com ([24.5.157.48]:24816 "EHLO
	siamese.dhis.twinsun.com") by vger.kernel.org with ESMTP
	id <S135216AbRDVFrx>; Sun, 22 Apr 2001 01:47:53 -0400
From: junio@siamese.dhis.twinsun.com
To: Manuel McLure <manuel@mclure.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rA0N-0004sv-00@the-village.bc.nu>
	<20010421211722.C976@ulthar.internal.mclure.org>
Date: 21 Apr 2001 22:47:01 -0700
In-Reply-To: <20010421211722.C976@ulthar.internal.mclure.org>
Message-ID: <7vpue5cwq2.fsf@siamese.dhis.twinsun.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only <include/asm-alpha/compiler.h> defines the following, but I
think we need this for other architectures, too.

/* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
   a mechanism by which the user can annotate likely branch directions and
   expect the blocks to be reordered appropriately.  Define __builtin_expect
   to nothing for earlier compilers.  */

#if __GNUC__ == 2 && __GNUC_MINOR__ < 96
#define __builtin_expect(x, expected_value) (x)
#endif
