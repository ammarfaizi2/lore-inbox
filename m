Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318652AbSIKKYw>; Wed, 11 Sep 2002 06:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318661AbSIKKYw>; Wed, 11 Sep 2002 06:24:52 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:45842 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318652AbSIKKYv>; Wed, 11 Sep 2002 06:24:51 -0400
Date: Wed, 11 Sep 2002 11:29:38 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Blackwell <jblack@linuxguru.net>
Cc: linux-kernel@vger.kernel.org, jonathan@buzzard.org.uk
Subject: Re: [PATCH] IRQ patch for Toshiba Char Driver in 2.5.34
Message-ID: <20020911112938.A25726@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Blackwell <jblack@linuxguru.net>,
	linux-kernel@vger.kernel.org, jonathan@buzzard.org.uk
References: <20020909115956.GA23290@comet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020909115956.GA23290@comet>; from jblack@linuxguru.net on Mon, Sep 09, 2002 at 07:59:57AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You've just made the driver horribly racy on SMP or preempt systems..

Instead of a blind search and replace you have to find out the protected
data and add a spinlock around it, also in the top-half of the kernel.
