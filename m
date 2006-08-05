Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWHEXLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWHEXLr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 19:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWHEXLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 19:11:47 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:24011 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1751421AbWHEXLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 19:11:46 -0400
Date: Sat, 5 Aug 2006 16:06:47 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Mark Fasheh <mark.fasheh@oracle.com>
cc: Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjan@linux.intel.com>,
       Dave Kleikamp <shaggy@austin.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Valerie Henson <val_henson@linux.intel.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Akkana Peck <akkana@shallowsky.com>,
       Jesse Barnes <jesse.barnes@intel.com>, jsipek@cs.sunysb.edu,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] [PATCH] Relative lazy atime
In-Reply-To: <20060805222247.GQ29686@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.63.0608051604420.20114@qynat.qvtvafvgr.pbz>
References: <20060803063622.GB8631@goober> <20060805122537.GA23239@lst.de> 
 <1154797123.12108.6.camel@kleikamp.austin.ibm.com> 
 <1154797475.3054.79.camel@laptopd505.fenrus.org>  <20060805183609.GA7564@tuatara.stupidest.org>
 <20060805222247.GQ29686@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Aug 2006, Mark Fasheh wrote:

> On Sat, Aug 05, 2006 at 11:36:09AM -0700, Chris Wedgwood wrote:
>> should it be atime-dirty or non-critical-dirty? (ie. make it more
>> generic to cover cases where we might have other non-critical fields
>> to flush if we can but can tolerate loss if we dont)
> So, just to be sure - we're fine with atime being lost due to crashes,
> errors, etc?

at least as a optional mode of operation yes.

I'm sure someone will want/need the existing 'update atime immediatly', and 
there are people who don't care about atime at all (and use noatime), but there 
is a large middle ground between them where atime is helpful, but doesn't need 
the real-time update or crash protection.

David Lang
