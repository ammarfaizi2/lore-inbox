Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbUCCFs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 00:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUCCFs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 00:48:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59825 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262396AbUCCFs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 00:48:56 -0500
Date: Wed, 3 Mar 2004 00:49:27 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Glen Nakamura <glen@imodulo.com>
cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Mysterious string truncation in 2.4.25 kernel
In-Reply-To: <20040303053547.GA3160@modulo.internal>
Message-ID: <Xine.LNX.4.44.0403030043380.32045-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Glen Nakamura wrote:

> Of course, perhaps 0 should passed instead of "" for data_page?
> 
> -    err = do_mount ("none", "/dev", "devfs", 0, "");
> +    err = do_mount ("none", "/dev", "devfs", 0, 0);
>
> Comments?

Yes, the devfs fix above is needed if the data_page patch has been 
applied.  

This is the case in 2.6, but not 2.4.25.


- James
-- 
James Morris
<jmorris@redhat.com>



