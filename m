Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268011AbTBWCRd>; Sat, 22 Feb 2003 21:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268012AbTBWCRc>; Sat, 22 Feb 2003 21:17:32 -0500
Received: from are.twiddle.net ([64.81.246.98]:24734 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S268011AbTBWCRc>;
	Sat, 22 Feb 2003 21:17:32 -0500
Date: Sat, 22 Feb 2003 18:27:41 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-kernel@vger.kernel.org
Subject: Re: alpha: Hangcheck timer doesn't compile
Message-ID: <20030222182741.A3177@twiddle.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030219085303.GJ351@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030219085303.GJ351@lug-owl.de>; from jbglaw@lug-owl.de on Wed, Feb 19, 2003 at 09:53:03AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 09:53:03AM +0100, Jan-Benedict Glaw wrote:
> This is because current_cpu_data doesn't (currently) exist on alpha.

Indeed.  Hangcheck is incorrectly assuming x86 datastructures.

Anyway, the driver as written isn't going to be useful on alpha
since the 32-bit TSC rolls over every 8 seconds.


r~
