Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWDYR2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWDYR2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWDYR2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:28:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:43819 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751566AbWDYR2O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:28:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HlcI7vQ8qE5aPoLY2n6xabqXDVU7Y8eqQMTg1033hlhM0rOc5mTYE1eTY6zeBHi1jLkgvTFhAAYYOa9XPNjlAONFIr1noowrOFnDioK8oy+VXLHbaPu0LpTY3IKEzR7WYMTKWBZcoSg55fP23xkNKUlmAOO12JrpHKjlvK7oazg=
Message-ID: <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com>
Date: Tue, 25 Apr 2006 13:28:13 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: Compiling C++ modules
Cc: "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <444E5A3E.1020302@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>
	 <1145911546.1635.54.camel@localhost.localdomain>
	 <444D3D32.1010104@argo.co.il>
	 <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com>
	 <444DCAD2.4050906@argo.co.il>
	 <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com>
	 <444E524A.10906@argo.co.il>
	 <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com>
	 <444E5A3E.1020302@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/06, Avi Kivity <avi@argo.co.il> wrote:
> Dmitry Torokhov wrote:
> >>>     TakeLock l(&lock);
> >>>
> >>>     do_something();
> >>>     do_something_else();
> >>>
> >>> First of all, that extra TakeLock object chews up stack, at least 4 or
> >>> 8 bytes of it, depending on your word size.
> >>>
> >> No, it's optimized out. gcc notices that &lock doesn't change and that
> >> 'l' never escapes the function.
> >>
> >
> > "l" that propects critical section gets thrown away???
> Calm down, the storage for 'l' is thrown away, but its effects remain.

Would you mind explaining implemenation details a little bit?

--
Dmitry
