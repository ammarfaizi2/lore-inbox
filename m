Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWADCZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWADCZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 21:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWADCZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 21:25:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965170AbWADCZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 21:25:44 -0500
Date: Tue, 3 Jan 2006 21:25:30 -0500
From: Dave Jones <davej@redhat.com>
To: Jan Blunck <jblunck@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Eliminate __attribute__ ((packed)) warnings for gcc-4.1
Message-ID: <20060104022530.GA29784@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jan Blunck <jblunck@suse.de>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060103113045.GB24131@hasse.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103113045.GB24131@hasse.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 12:30:45PM +0100, Jan Blunck wrote:
 >  typedef struct T30_s {
 >  	/* session parameters */
 > -	__u8 resolution		__attribute__ ((packed));
 > -	__u8 rate		__attribute__ ((packed));
 > -	__u8 width		__attribute__ ((packed));
 > -	__u8 length		__attribute__ ((packed));
 > -	__u8 compression	__attribute__ ((packed));
 > -	__u8 ecm		__attribute__ ((packed));
 > -	__u8 binary		__attribute__ ((packed));
 > -	__u8 scantime		__attribute__ ((packed));
 > -	__u8 id[FAXIDLEN]	__attribute__ ((packed));
 > +	__u8 resolution;
 > +	__u8 rate		;
 > +	__u8 width		;
 > +	__u8 length		;
 > +	__u8 compression	;
 > +	__u8 ecm		;
 > +	__u8 binary		;
 > +	__u8 scantime		;
 > +	__u8 id[FAXIDLEN]	;

What's with the funky placement of ; ?
The rest of the struct looks sensible.

 >  	
 >  	/* various cruft */
 > -	u32     dataA[6] __attribute((packed));   
 > -        u16	dataB[5] __attribute((packed));   
 > -  	u32     dataC[14] __attribute((packed)); 	
 > -};
 > +	u32     dataA[6];
 > +        u16	dataB[5];
 > +  	u32     dataC[14];
 > +} __attribute((packed));

You could fix the horked indentation at the same time.
(This crops up in a few places in this diff)

		Dave

