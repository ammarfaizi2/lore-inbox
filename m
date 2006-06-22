Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWFVPqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWFVPqz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWFVPqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:46:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:55955 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030192AbWFVPqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:46:54 -0400
Date: Thu, 22 Jun 2006 08:45:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Nathan Lynch <ntl@pobox.com>, akpm@osdl.org,
       kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com, pavel@ucw.cz, ak@suse.de, nickpiggin@yahoo.com.au,
       mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <20060622084513.4717835e.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0606220844430.28341@schroedinger.engr.sgi.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org> <20060622150848.GL16029@localdomain>
 <20060622084513.4717835e.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Randy.Dunlap wrote:

> Sounds much better than just killing the process.

Right and having active interrupts or devices using that processor should 
also stop offlining a processor.

So just remove everything from a processor before offlining. If you cannot 
remove all users then the processor cannot be offlined.

