Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWD0MhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWD0MhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWD0MhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:37:21 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:5611 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S965110AbWD0MhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:37:20 -0400
Date: Thu, 27 Apr 2006 14:37:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Cc: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
Message-ID: <20060427123701.GG32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4450A1C0.3080209@de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 April 2006 12:49:36 +0200, Heiko J Schick wrote:
> +u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle 
> adapter_handle,
> +			     struct ehca_pfqp *pfqp,
> +			     const u8 servicetype,
> +			     const u8 daqp_ctrl,
> +			     const u8 signalingtype,
> +			     const u8 ud_av_l_key_ctl,
> +			     const struct ipz_cq_handle send_cq_handle,
> +			     const struct ipz_cq_handle receive_cq_handle,
> +			     const struct ipz_eq_handle async_eq_handle,
> +			     const u32 qp_token,
> +			     const struct ipz_pd pd,
> +			     const u16 max_nr_send_wqes,
> +			     const u16 max_nr_receive_wqes,
> +			     const u8 max_nr_send_sges,
> +			     const u8 max_nr_receive_sges,
> +			     const u32 ud_av_l_key,
> +			     struct ipz_qp_handle *qp_handle,
> +			     u32 * qp_nr,
> +			     u16 * act_nr_send_wqes,
> +			     u16 * act_nr_receive_wqes,
> +			     u8 * act_nr_send_sges,
> +			     u8 * act_nr_receive_sges,
> +			     u32 * nr_sq_pages,
> +			     u32 * nr_rq_pages,
> +			     struct h_galpas *h_galpas);

25 parameters?  If you tell me which drugs were involved in this code,
I know what to stay away from.  Might be the current record for any
code ever proposed for inclusion.

The whole patch is full of parameter-happy functions with this one
being the ugly top of the iceberg.  I sincerely hope this is not a
defined ABI and can still be changed.

Jörn

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
-- Brian W. Kernighan
