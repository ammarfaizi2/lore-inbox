Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWBBRGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWBBRGc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWBBRGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:06:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:31370 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932173AbWBBRGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:06:32 -0500
Subject: Re: [RFC][PATCH 5/7] VPIDs: vpid/pid conversion in VPID enabled
	case
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@openvz.org>
Cc: serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
In-Reply-To: <43E23398.7090608@openvz.org>
References: <43E22B2D.1040607@openvz.org>  <43E23398.7090608@openvz.org>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 09:05:51 -0800
Message-Id: <1138899951.29030.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-02 at 19:30 +0300, Kirill Korotaev wrote:
> This is the main patch which contains all vpid-to-pid conversions
> and auxilliary stuff. Virtual pids are distinguished from real ones
> by the VPID_BIT bit set. Conversion from vpid to pid and vice versa
> is performed in two ways: fast way, when vpid and it's according pid
> differ only in VPID_BIT bit set ("linear" case), and more complex way,
> when pid may correspond to any vpid ("sparse" case) - in this case we
> use a hash-table based mapping. 

This is an interesting approach.  Could you elaborate a bit on on why
you need the two different approaches?  What conditions cause the switch
to the sparse approach?

Also, if you could separate those two approaches out into two different
patches, it would be much easier to get a grasp about what's going on.
One of them is just an optimization, right?

Did you happen to catch Linus's mail about his preferred approach?  

http://marc.theaimsgroup.com/?l=linux-kernel&m=113874154731279&w=2

-- Dave

