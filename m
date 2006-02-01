Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWBASCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWBASCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 13:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWBASCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 13:02:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38827 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932448AbWBASCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 13:02:42 -0500
Date: Wed, 1 Feb 2006 18:02:37 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Akinobu Mita'" <mita@miraclelinux.com>, Grant Grundler <iod00d@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
Message-ID: <20060201180237.GA18464@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Akinobu Mita' <mita@miraclelinux.com>,
	Grant Grundler <iod00d@hp.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	linux-ia64@vger.kernel.org
References: <20060126032918.GB9984@miraclelinux.com> <200602011511.k11FBgg00314@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602011511.k11FBgg00314@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 07:11:34AM -0800, Chen, Kenneth W wrote:
> Akinobu Mita wrote on Wednesday, January 25, 2006 7:29 PM
> > This patch introduces the C-language equivalents of the functions below:
> > 
> > - atomic operation:
> > void set_bit(int nr, volatile unsigned long *addr);
> > void clear_bit(int nr, volatile unsigned long *addr);
> > void change_bit(int nr, volatile unsigned long *addr);
> > int test_and_set_bit(int nr, volatile unsigned long *addr);
> > int test_and_clear_bit(int nr, volatile unsigned long *addr);
> > int test_and_change_bit(int nr, volatile unsigned long *addr);
> 
> I wonder why you did not make these functions take volatile
> unsigned int * address argument?

Because they are defined to operate on arrays of unsigned long
