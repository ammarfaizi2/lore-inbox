Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbRGZPqp>; Thu, 26 Jul 2001 11:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbRGZPqf>; Thu, 26 Jul 2001 11:46:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18949 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268086AbRGZPqU>; Thu, 26 Jul 2001 11:46:20 -0400
Date: Thu, 26 Jul 2001 12:45:30 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Validating Pointers
Message-ID: <20010726124529.B2548@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Cress, Andrew R" <andrew.r.cress@intel.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <9678C2B4D848D41187450090276D1FAE1008EAA8@FMSMSX32>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <9678C2B4D848D41187450090276D1FAE1008EAA8@FMSMSX32>; from andrew.r.cress@intel.com on Thu, Jul 26, 2001 at 08:36:49AM -0700
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Em Thu, Jul 26, 2001 at 08:36:49AM -0700, Cress, Andrew R escreveu:
> 
> Is there a general (correct) kernel subroutine to validate a pointer
> received in a routine as input from the outside world?  Is access_ok() a
> good one to use?

normally one uses get_user & friends and copy_from_user and friends
checking its return and returning -EFAULT if they fail
