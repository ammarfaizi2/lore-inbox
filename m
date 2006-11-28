Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934524AbWK1CZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934524AbWK1CZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 21:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934526AbWK1CZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 21:25:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62897 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S934524AbWK1CZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 21:25:56 -0500
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       Karim Yaghmour <karim@opersys.com>, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Richard J Moore <richardj_moore@uk.ibm.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 3/16] LTTng 0.6.36 for 2.6.18 : Linux Kernel Markers
References: <20061124215401.GD25048@Krystal>
From: fche@redhat.com (Frank Ch. Eigler)
Date: 27 Nov 2006 21:23:17 -0500
In-Reply-To: <20061124215401.GD25048@Krystal>
Message-ID: <y0mu00kpawa.fsf@ton.toronto.redhat.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> writes:

> This patch adds the Linux Kernel Markers [...]
> Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

If it helps,
Acked-by: Frank Ch. Eigler <fche@redhat.com>


One question:

> [...]
> +	/* Markers in modules. */ 
> +	list_for_each_entry(mod, &modules, list) {
> +		if (mod->license_gplok)
> +			found += marker_set_probe_range(name, format, probe,
> +				mod->markers, mod->markers+mod->num_markers);
> +	}
> [...]
> +EXPORT_SYMBOL(marker_set_probe);

Are you sure the license_gplok check is necessary here?  We should
consider encouraging non-gpl module writers to instrument their code,
to give users a slightly better chance of debugging problems.


- FChE
