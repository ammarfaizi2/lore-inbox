Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313261AbSDDQpX>; Thu, 4 Apr 2002 11:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313262AbSDDQpQ>; Thu, 4 Apr 2002 11:45:16 -0500
Received: from imladris.infradead.org ([194.205.184.45]:15889 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313258AbSDDQpC>; Thu, 4 Apr 2002 11:45:02 -0500
Date: Thu, 4 Apr 2002 17:44:55 +0100
From: "'Christoph Hellwig'" <hch@infradead.org>
To: Dana Lacoste <dana.lacoste@peregrine.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>, Alfonso Gazo <agazo@unex.es>,
        linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] /proc/stat does not show disk_io stats for all IDE d isks
Message-ID: <20020404174455.A28340@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	Dana Lacoste <dana.lacoste@peregrine.com>,
	Alfonso Gazo <agazo@unex.es>, linux-kernel@vger.kernel.org
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2D9A@OTTONEXC1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 08:20:24AM -0800, Dana Lacoste wrote:
> > Could you please tru 2.4.18-ac/2.4.19-ac?
> 
> the SARD stuff from Alan's tree fixes this (in /proc/partitions though, but
> that's ok)
> 
> the problem is that /proc/stat only checks major/minor combinations for
> majors 0-16 and minors 0-16.  so if you have, say, hdc on major 22 then
> it won't show up in /proc/stat.  Basically it's just done wrong :)
> 
> SARD fixes this by tracking all the relevant disk info properly, but it's
> not in the mainline kernel :(

I guess it will be in 2.4.19..

