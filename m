Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWHUSxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWHUSxP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWHUSxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:53:11 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:28610 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWHUSwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:52:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KBL/OxBkIKYmnvZsfOzVW91Ojo//FYbIUGfRhBPiHIGZokIr8z8S6AZHK2wv6EjKWr3/Nzy+RoC5c2XQN0bnT/oAkTinzfiTMbrE6aR/H9aDrvV6YWH181q+1OaOEW2Szb9G68EY6oyeMvg9Kvzf7NhbqyC2LdLoGdXLMnsnh50=
Message-ID: <a762e240608211152x5d4f11f0wd26f7e3d75d38e0a@mail.gmail.com>
Date: Mon, 21 Aug 2006 11:52:39 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Mel Gorman" <mel@csn.ul.ie>
Subject: Re: [PATCH 0/6] Sizing zones and holes in an architecture independent manner V9
Cc: akpm@osdl.org, tony.luck@intel.com, linux-mm@kvack.org, ak@suse.de,
       bob.picco@hp.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
In-Reply-To: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/06, Mel Gorman <mel@csn.ul.ie> wrote:
> This is V9 of the patchset to size zones and memory holes in an
> architecture-independent manner. It booted successfully on 5 different
> machines (arches were x86, x86_64, ppc64 and ia64) in a number of different
> configurations and successfully built a kernel. If it fails on any machine,
> booting with loglevel=8 and the console log should tell me what went wrong.
>

I am wondering why this new api didn't cleanup the pfn_to_nid code
path as well. Arches are left to still keep another set of
nid-start-end info around. We are sending info like

add_active_range(unsigned int nid, unsigned long start_pfn, unsigned
long end_pfn)

With this info making a common pnf_to_nid seems to be of intrest so we
don't have to keep redundant information in both generic and arch
specific data structures.

Are you intending the hot-add memory code path to call add_active_range or ???

Thanks,
  Keith
