Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030451AbWHUNDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030451AbWHUNDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWHUNDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:03:54 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:2241 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030446AbWHUNDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:03:52 -0400
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [2.6.19 PATCH 1/7] ehea: interface to network stack
Date: Mon, 21 Aug 2006 14:23:53 +0200
User-Agent: KMail/1.8.2
Cc: netdev@vger.kernel.org, Christoph Raisch <raisch@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <osstklei@de.ibm.com>, Thomas Klein <tklein@de.ibm.com>
References: <200608181329.02042.ossthema@de.ibm.com> <20060818144429.GF5201@martell.zuzino.mipt.ru>
In-Reply-To: <20060818144429.GF5201@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608211423.54250.ossthema@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Friday 18 August 2006 16:44, Alexey Dobriyan wrote:
> > +static int ehea_init_port_res(struct ehea_port *port, struct ehea_port_res *pr,
> > +			      struct port_res_cfg *pr_cfg, int queue_token)
> > +{
> > +	int ret = -EINVAL;
> > +	int max_rq_entries = 0;
> > +	enum ehea_eq_type eq_type = EHEA_EQ;
> > +	struct ehea_qp_init_attr *init_attr = NULL;
> > +	struct ehea_adapter *adapter = port->adapter;
> > +
> > +	memset(pr, 0, sizeof(struct ehea_port_res));
> > +
> > +	pr->skb_arr_rq3 = NULL;
> > +	pr->skb_arr_rq2 = NULL;
> > +	pr->skb_arr_rq1 = NULL;
> > +	pr->skb_arr_sq = NULL;
> > +	pr->qp = NULL;
> > +	pr->send_cq = NULL;
> > +	pr->recv_cq = NULL;
> > +	pr->send_eq = NULL;
> > +	pr->recv_eq = NULL;
> 
> After memset unneeded. ;-)
> 

Is it valid (common in the kernel environment) to treat NULL as 0 after a memset
and thus to forget about initialization?

Thanks,
Jan-Bernd
