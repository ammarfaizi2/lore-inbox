Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTBEODj>; Wed, 5 Feb 2003 09:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTBEODj>; Wed, 5 Feb 2003 09:03:39 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:56585 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261354AbTBEODi>; Wed, 5 Feb 2003 09:03:38 -0500
Date: Wed, 5 Feb 2003 14:13:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030205141308.A20077@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302051345.IAA05814@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302051345.IAA05814@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Wed, Feb 05, 2003 at 08:45:16AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 08:45:16AM -0500, Stephen D. Smalley wrote:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104316038729345&w=2 and
> http://marc.theaimsgroup.com/?l=linux-security-module&m=104316278400987&w=2.
> At most, a field might be added to the ctl_table structure so that the kernel
> can provide a hint to security modules as to its view of the sensitivity of
> a given sysctl variable, but this does not require any change to the sysctl
> hook interface.

Of course that needs further changes!

(a) actually implement that field, and
(b) change the prototype of the hook to int (*sysctl)(int op, enum sensitivity);

