Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314244AbSDRIbK>; Thu, 18 Apr 2002 04:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314264AbSDRIbJ>; Thu, 18 Apr 2002 04:31:09 -0400
Received: from unthought.net ([212.97.129.24]:42702 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S314244AbSDRIbI>;
	Thu, 18 Apr 2002 04:31:08 -0400
Date: Thu, 18 Apr 2002 10:31:07 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: Nikita@Namesys.COM, Andrey Ulanov <drey@rt.mipt.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: FPU, i386
Message-ID: <20020418103107.B28396@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
	Nikita@Namesys.COM, Andrey Ulanov <drey@rt.mipt.ru>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200204171440.JAA76065@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 09:40:48AM -0500, Jesse Pollard wrote:
...
> Been there done that... My solution (based on the problem I was working
> in) was to multiply both sides by the 10^<number of siginificant digits
> of the problem set>. Taking the simplistic approach:
> 
> if (int(1/h * 100) == int(5.0 * 100))

The common solution I've seen and used is
  if  (fabs(a-b) < e)

Set e according to your needs (1E-4 is good enough for many practical purposes,
1E-12 is better for my personal gut-feeling in many problems, 1E-16 and beyond
does not make any sense what so ever (for double precision))

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
