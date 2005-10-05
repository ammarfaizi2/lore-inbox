Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbVJEQ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbVJEQ7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbVJEQ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:59:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:63948 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030266AbVJEQ7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:59:19 -0400
Subject: Re: [PATCH 1/5] AMD Geode GX/LX support V2
From: Dave Hansen <haveblue@us.ibm.com>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       info-linux@ldcmail.amd.com
In-Reply-To: <20051005165405.GB25189@cosmic.amd.com>
References: <20051005164626.GA25189@cosmic.amd.com>
	 <20051005165405.GB25189@cosmic.amd.com>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 09:59:08 -0700
Message-Id: <1128531548.26009.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 10:54 -0600, Jordan Crouse wrote:
> +/* This function handles National Semiconductor branded processors */
> +
> +static void __init init_nsc(struct cpuinfo_x86 *c)
> +{
> +       int r;
> +
> +       /* There may be GX1 processors in the wild that are branded
> +        * NSC and not Cyrix.
> +        *
> +        * This function only handles the GX processor, and kicks
> every
> +        * thing else to the Cyrix init function above - that should
> +        * cover any processors that might have been branded
> differently
> +        * after NSC aquired Cyrix.
> +        *
> +        * If this breaks your GX1 horribly, please e-mail
> +        * info-linux@ldcmail.amd.com to tell us.
> +        */
> +
> +       /* Handle the GX (Formally known as the GX2) */
> +
> +       if ((c->x86 == 5) && (c->x86_model == 5)) {
> +               r = get_model_name(c);
> +               display_cacheinfo(c);
> +       }
> +       else
> +               init_cyrix(c);
> +}

CodingStyle.  Please keep the bracket and the else on the same line:

        if {
        	foo();
        } else
        	bar();
        
-- Dave

