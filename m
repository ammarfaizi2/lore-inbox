Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265967AbUF2TPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265967AbUF2TPc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUF2TPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:15:30 -0400
Received: from vsat-148-63-57-162.c001.g4.mrt.starband.net ([148.63.57.162]:4572
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265967AbUF2TO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:14:56 -0400
Message-ID: <40E1BEEE.9050000@redhat.com>
Date: Tue, 29 Jun 2004 12:11:42 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: inconsistency between SIOCGIFCONF and SIOCGIFNAME
References: <40E0EAC1.50101@redhat.com> <20040629093234.459c46c6@dell_ss3.pdx.osdl.net>
In-Reply-To: <20040629093234.459c46c6@dell_ss3.pdx.osdl.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

> The bridge utilities depends on being able to do if_indextoname and
> if_nametoindex for interfaces that aren't active to IP.  Other non-IP
> usage probably does as well.

This is not changed by DaveM's patch.  All the patch does is to cause
SIOCGIFCONF to report all interfaces SIOCGIFINDEX knows about as well.
So now if_indextoname() succeeds only if_indexname() also returns the
interface name, making the three interfaces consistent.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
