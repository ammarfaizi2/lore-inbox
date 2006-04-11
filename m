Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWDKS5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWDKS5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 14:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWDKS5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 14:57:32 -0400
Received: from detroit.securenet-server.net ([209.51.153.26]:50894 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1750987AbWDKS5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 14:57:31 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Binary sysfs blobs
Date: Tue, 11 Apr 2006 11:57:25 -0700
User-Agent: KMail/1.9.1
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
References: <20060411110841.71390306.zaitcev@redhat.com>
In-Reply-To: <20060411110841.71390306.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604111157.25885.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 11, 2006 11:08 am, Pete Zaitcev wrote:
> Hi, Greg:
>
> I was reviewing some patches here and noticed (yes, only now noticed)
> that we have operations on binary blobs in fs/sysfs/bin.c. I thought
> it wasn't part of the deal for sysfs, with one value per file and so
> on. I suppose it's too late to debate now, but I have a couple of
> questions:
>
>  - Do you know of any conventions which allow to determine which file
>    is binary? Maybe the name starting with an underscore or something?

AFAIK there isn't any convention.  The PCI related files 
(/sys/bus/pci/devices/...) don't have a particular naming scheme for 
example.

>  - Is there a standing policy that reading from a sysfs file is not
>    altering a state of the corresponding hardware? This is not related
>    to blobs directly, but with people passing structs now, it's
> tempting to implement some extended protocols. I am concerned of
> stealing network packets by accident or something.

Nope, again if you access the PCI files you may end up programming the 
hardware in some way.  There may be other examples of this elsewhere, 
but I haven't looked.

Jesse
