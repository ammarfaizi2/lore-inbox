Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263177AbTCWUQl>; Sun, 23 Mar 2003 15:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263178AbTCWUQl>; Sun, 23 Mar 2003 15:16:41 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:47630 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263177AbTCWUQk>; Sun, 23 Mar 2003 15:16:40 -0500
Date: Sun, 23 Mar 2003 20:27:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Dittmer <j.dittmer@portrix.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: i2c-via686a driver
Message-ID: <20030323202743.A11150@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Dittmer <j.dittmer@portrix.net>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <3E7E0B37.5060505@portrix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E7E0B37.5060505@portrix.net>; from j.dittmer@portrix.net on Sun, Mar 23, 2003 at 08:29:59PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

// The following register sets temp interrupt mode (bits 1-0 for temp1, 
// 3-2 for temp2, 5-4 for temp3).  Modes are:
//    00 interrupt stays as long as value is out-of-range
//    01 interrupt is cleared once register is read (default)
//    10 comparator mode- like 00, but ignores hysteresis
//    11 same as 00

	Please don't use C++-style comments in kernel code.

static inline u8 TEMP_TO_REG(long val)
{
	return (u8)
	    SENSORS_LIMIT(viaLUT[((val <= -500) ? 0 : (val >= 1100) ? 160 : 
				  ((val + 5) / 10 + 50))], 0, 255);
}

	Dead code?

static int via686a_id = 0;

	This doesn't need to be initialized.

      ERROR4:

	All-uppercase is ugly..
      
