Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVHWPGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVHWPGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHWPGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:06:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:10918 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932191AbVHWPGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:06:21 -0400
Date: Tue, 23 Aug 2005 20:37:57 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, mingo@elte.hu, hawkes@sgi.com
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains on partial nodes temp fix
Message-ID: <20050823150757.GA8580@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050823080427.14740.20177.sendpatchset@jackhammer.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20050823080427.14740.20177.sendpatchset@jackhammer.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2005 at 01:04:27AM -0700, Paul Jackson wrote:
> If Dinakar, Hawkes and Nick concur (and no one else complains too
> loud) then the following should go into 2.6.13, to avoid the potential
> kernel oops that Hawkes reported in Dinakar's feature to allow user
> control of dynamic sched domain placement using cpu_exclusive cpusets.

I agree this is the way to go for 2.6.13 before we fix things the
right way for 2.6.14. Thanks for the patch Paul.

> This patch should allow proceeding with this new feature in 2.6.13 for
> the configurations in which it is useful (node alligned sched domains)
> while avoiding trying to setup sched domains in the less useful cases
> that can cause the kernel corruption and oops.
> 

Dunno if it is something in my setup (4 CPU Power5 box with NUMA enabled)
but this patch causes some hard hangs when I run the attached script.
The same script runs for much longer with Ingo's changes but panics
as I had described earlier. I am still debugging what causes this.

	-Dinakar



--gKMricLos+KVdGMg
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="sd-stress.tar.gz"
Content-Transfer-Encoding: base64

H4sIAGQ5C0MAA+1YW2/bNhT2q/UrWNsP3YMjkr5tGVxg6II2gJMGidc+FMWgWXQsTBdDlJPu
3+9QsinqGipRgz7ovMgiP57znaskc3sc+OyM73o/TjDBeDGb9TDGZDEj4orJdBpfhcznix7B
E0wn88l0AThCpgvcQ/gHcpJy4JEVItSzHT+ox7GQvwah15XhG/Mfxzf5zjDY930QRujqen3z
6fJ6vTQ3e3A64qeN9cXVzZ+Xt2Q5OkHMiHn7s9FoTHIYuhyd0BJDpYX3N3/dXS3xeKIuwD1R
7z+SJc7c0yWRGr58vlNYPD5wMCAprGEPAGaUUr+4/gC0Ycdk/j1RVqlcpafV1So57roZwsJk
jrKwhMdUXYoN4dyKYK6sgIGJYdy9v728WUOEluYu8Jgp6k9E3A48k29CZw/sjZFEmdwe8yhk
nJ+JXLWWf1Vta0pzUt//hGBKc/1PKZl1/f8aovS/Fxz8CI0jlPQ98uHBgGSXIfoOmTZ7MP0D
dMbGTncMY4igjMg5uoNT7PvGPXDngaHAR49OtAM9sUaDbXYBGmggB4b3r+2EaLxHcozEFuVN
zDnWh9E75DGPK0sElkDN31J/bNkImWUfqdICge1WMoAW5ehrurcP2YMTHLj7H/D8lnrxAiWD
nAP1bCfn6A/bTlRGAbIUk0mmUk5PQge1cUr3RmJQJfu8QGhalb90xXIFXjibkmt0rJ5ontEs
8ZtbHkOidINtEgOLg3KHR45/DzpZJiWZZD5TwUA3ZPPKYlH1pXz08M3qaKGhUyZgu03JNDzY
jNWv5+iWeQGoiAO+DQOvtsT18I3q/COpSttvuX7ya4g9jdWuFoLPUeiJEVhtrhozyE7nBJTO
zoKxsnEcD4/jcyDONId3lNg3hUGzg02meiY6Lxz2pDioj3Nnb4XMz9W14l6jc/VFX/Ccqp7T
QkHStnyf6PugTJ9GxwZVSSzSq/BZw49ptrnUAlPKf+e4NvBTHGl0rtKTOClXld06KxlJ9ZbQ
W8d12b3l/qJwfYmaeurVA47Mn2G0wPz5Sup5l7LeuMzyD/uj+eNdTk925lHtgZjovPAjFopy
EZ8GEUq+j1DEOIzWGPcIXjD0FUXhgaFvvxt2YPQzJvpHG/DRmH1vNvrpKIDN5Fj8o6TT+7lw
CG3HiPTruqd2U2UAH7AJg/iHBgPAtctgtUoIiKuG/dWqXfPicz0hkPzSoCCArZOgkgTVJUHb
ICFzf6zXJArpDTWUCj31jYKHtFVXPmwNkfj3J24dXkCWvA70M138RCTKHKp7CGtHKjN79C1W
Hqun8lKi6XCvIVOaIxnoZrnIqG45R0UiNEOEFt0vawRJZajTACU+loS9ikUTtdkXCWCXAQ7r
UquVjTws/xx8og5s+MRt76/FTjrppJNOOumkk0466aSTTjrp5CeR/wHARxE1ACgAAA==

--gKMricLos+KVdGMg--
