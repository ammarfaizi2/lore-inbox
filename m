Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWHPNVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWHPNVa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWHPNVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:21:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53207 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750722AbWHPNV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:21:29 -0400
Date: Wed, 16 Aug 2006 14:20:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, David Smith <dsmith@redhat.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060816132043.GA16814@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
	David Smith <dsmith@redhat.com>,
	Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
	linux-kernel@vger.kernel.org, shemminger@osdl.org
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com> <20060809161039.GA30856@infradead.org> <20060809161854.GA13622@infradead.org> <20060810071028.A18344@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060810071028.A18344@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 07:10:29AM -0700, Keshavamurthy Anil S wrote:
> This should be p->addr = (kprobe_opcode_t *)(((char *)p->addr) + p->offset), since p->addr is of type
> pointer to kprobe_opcode_t and the size of kprobe_opcode_t is different for different
> architecture. At least for ia64 this p->addr type is not a pointer to char.

Similarly for powerpc.  We should either put this change in or drop the
offset into symbol support until actual users pop up..
