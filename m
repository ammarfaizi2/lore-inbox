Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSGQT6r>; Wed, 17 Jul 2002 15:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGQT6r>; Wed, 17 Jul 2002 15:58:47 -0400
Received: from [195.137.34.203] ([195.137.34.203]:28848 "HELO sam.home.net")
	by vger.kernel.org with SMTP id <S314459AbSGQT6q>;
	Wed, 17 Jul 2002 15:58:46 -0400
Date: Wed, 17 Jul 2002 21:14:17 +0100
From: Sam Mason <mason@f2s.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: shreenivasa H V <shreenihv@usa.net>, linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
Message-ID: <20020717201417.GA9546@sam.home.net>
References: <Pine.LNX.4.44.0207181818300.29003-100000@localhost.localdomain> <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 07:40:19PM +0200, Ingo Molnar wrote:
>Can you point out specific (real-life) workloads where this
>would be advantegous?

It's mainly used for programs that needs lots of processing power
chucked at a specific problem, the problem is first broken down into
several small pieces and each part is sent off to a different
processor.  When each piece has been processed, they are all
recombined and the rest of the calculation is continued.  The problem
with this is that if any one of the pieces is delayed, all the
processors will be idle waiting for the interrupted piece to be
processed, before they can process the next set of pieces.

  Sam
