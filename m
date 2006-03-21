Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWCUQck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWCUQck (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWCUQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:32 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29452 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030304AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 29/46] kbuild: kill trailing whitespace in modpost & friends
In-Reply-To: <11429580563217-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580563392-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/mod/file2alias.c   |    4 +--
 scripts/mod/mk_elfconfig.c |    4 +--
 scripts/mod/modpost.c      |   70 ++++++++++++++++++++++----------------------
 scripts/mod/modpost.h      |    8 +++--
 4 files changed, 43 insertions(+), 43 deletions(-)

62070fa42c4ac23d1d71146a4c14702302b80245
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 1346223..e7b5350 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -34,7 +34,7 @@ typedef uint16_t	__u16;
 typedef unsigned char	__u8;
 
 /* Big exception to the "don't include kernel headers into userspace, which
- * even potentially has different endianness and word sizes, since 
+ * even potentially has different endianness and word sizes, since
  * we handle those differences explicitly below */
 #include "../../include/linux/mod_devicetable.h"
 #include "../../include/linux/input.h"
@@ -228,7 +228,7 @@ static int do_pci_entry(const char *file
 	return 1;
 }
 
-/* looks like: "ccw:tNmNdtNdmN" */ 
+/* looks like: "ccw:tNmNdtNdmN" */
 static int do_ccw_entry(const char *filename,
 			struct ccw_device_id *id, char *alias)
 {
diff --git a/scripts/mod/mk_elfconfig.c b/scripts/mod/mk_elfconfig.c
index de2aabf..3c92c83 100644
--- a/scripts/mod/mk_elfconfig.c
+++ b/scripts/mod/mk_elfconfig.c
@@ -6,7 +6,7 @@
 int
 main(int argc, char **argv)
 {
-	unsigned char ei[EI_NIDENT];	
+	unsigned char ei[EI_NIDENT];
 	union { short s; char c[2]; } endian_test;
 
 	if (argc != 2) {
@@ -57,7 +57,7 @@ main(int argc, char **argv)
 
 	if ((strcmp(argv[1], "v850") == 0) || (strcmp(argv[1], "h8300") == 0))
 		printf("#define MODULE_SYMBOL_PREFIX \"_\"\n");
-	else 
+	else
 		printf("#define MODULE_SYMBOL_PREFIX \"\"\n");
 
 	return 0;
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 663b1ef..5de3c63 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -85,7 +85,7 @@ static struct module *new_module(char *m
 {
 	struct module *mod;
 	char *p, *s;
-	
+
 	mod = NOFAIL(malloc(sizeof(*mod)));
 	memset(mod, 0, sizeof(*mod));
 	p = NOFAIL(strdup(modname));
@@ -320,9 +320,9 @@ static void parse_elf(struct elf_info *i
 			continue;
 
 		info->symtab_start = (void *)hdr + sechdrs[i].sh_offset;
-		info->symtab_stop  = (void *)hdr + sechdrs[i].sh_offset 
+		info->symtab_stop  = (void *)hdr + sechdrs[i].sh_offset
 			                         + sechdrs[i].sh_size;
-		info->strtab       = (void *)hdr + 
+		info->strtab       = (void *)hdr +
 			             sechdrs[sechdrs[i].sh_link].sh_offset;
 	}
 	if (!info->symtab_start) {
@@ -387,15 +387,15 @@ static void handle_modversions(struct mo
 			/* Ignore register directives. */
 			if (ELF_ST_TYPE(sym->st_info) == STT_SPARC_REGISTER)
 				break;
- 			if (symname[0] == '.') {
- 				char *munged = strdup(symname);
- 				munged[0] = '_';
- 				munged[1] = toupper(munged[1]);
- 				symname = munged;
- 			}
+			if (symname[0] == '.') {
+				char *munged = strdup(symname);
+				munged[0] = '_';
+				munged[1] = toupper(munged[1]);
+				symname = munged;
+			}
 		}
 #endif
-		
+
 		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
 			   strlen(MODULE_SYMBOL_PREFIX)) == 0)
 			mod->unres = alloc_symbol(symname +
@@ -458,13 +458,13 @@ static char *get_modinfo(void *modinfo, 
 static int strrcmp(const char *s, const char *sub)
 {
         int slen, sublen;
-	
+
 	if (!s || !sub)
 		return 1;
-	
+
 	slen = strlen(s);
         sublen = strlen(sub);
-	
+
 	if ((slen == 0) || (sublen == 0))
 		return 1;
 
@@ -485,7 +485,7 @@ static int strrcmp(const char *s, const 
  *   tosec   = .init.data
  *   fromsec = .data
  *   atsym   =__param*
- *   
+ *
  * Pattern 2:
  *   Many drivers utilise a *_driver container with references to
  *   add, remove, probe functions etc.
@@ -508,7 +508,7 @@ static int secref_whitelist(const char *
 		"_probe_one",
 		NULL
 	};
-	
+
 	/* Check for pattern 1 */
 	if (strcmp(tosec, ".init.data") != 0)
 		f1 = 0;
@@ -521,7 +521,7 @@ static int secref_whitelist(const char *
 		return f1;
 
 	/* Check for pattern 2 */
-	if ((strcmp(tosec, ".init.text") != 0) && 
+	if ((strcmp(tosec, ".init.text") != 0) &&
 	    (strcmp(tosec, ".exit.text") != 0))
 		f2 = 0;
 	if (strcmp(fromsec, ".data") != 0)
@@ -570,7 +570,7 @@ static void find_symbols_between(struct 
 	Elf_Addr afterdiff = ~0;
 	const char *secstrings = (void *)hdr +
 				 elf->sechdrs[hdr->e_shstrndx].sh_offset;
-	
+
 	*before = NULL;
 	*after = NULL;
 
@@ -614,7 +614,7 @@ static void warn_sec_mismatch(const char
 	const char *secstrings = (void *)hdr +
 				 sechdrs[hdr->e_shstrndx].sh_offset;
 	const char *secname = secstrings + sechdrs[sym->st_shndx].sh_name;
-	
+
 	find_symbols_between(elf, r.r_offset, fromsec, &before, &after);
 
 	refsym = find_elf_symbol(elf, r.r_addend, sym);
@@ -622,10 +622,10 @@ static void warn_sec_mismatch(const char
 		refsymname = elf->strtab + refsym->st_name;
 
 	/* check whitelist - we may ignore it */
-	if (before && 
+	if (before &&
 	    secref_whitelist(secname, fromsec, elf->strtab + before->st_name))
 		return;
-	
+
 	if (before && after) {
 		warn("%s - Section mismatch: reference to %s:%s from %s "
 		     "between '%s' (at offset 0x%llx) and '%s'\n",
@@ -636,13 +636,13 @@ static void warn_sec_mismatch(const char
 	} else if (before) {
 		warn("%s - Section mismatch: reference to %s:%s from %s "
 		     "after '%s' (at offset 0x%llx)\n",
-		     modname, secname, refsymname, fromsec, 
+		     modname, secname, refsymname, fromsec,
 		     elf->strtab + before->st_name,
 		     (long long)r.r_offset);
 	} else if (after) {
 		warn("%s - Section mismatch: reference to %s:%s from %s "
 		     "before '%s' (at offset -0x%llx)\n",
-		     modname, secname, refsymname, fromsec, 
+		     modname, secname, refsymname, fromsec,
 		     elf->strtab + before->st_name,
 		     (long long)r.r_offset);
 	} else {
@@ -676,7 +676,7 @@ static void check_sec_ref(struct module 
 	Elf_Shdr *sechdrs = elf->sechdrs;
 	const char *secstrings = (void *)hdr +
 				 sechdrs[hdr->e_shstrndx].sh_offset;
-		
+
 	/* Walk through all sections */
 	for (i = 0; i < hdr->e_shnum; i++) {
 		Elf_Rela *rela;
@@ -724,13 +724,13 @@ static int init_section(const char *name
 
 /**
  * Identify sections from which references to a .init section is OK.
- * 
+ *
  * Unfortunately references to read only data that referenced .init
  * sections had to be excluded. Almost all of these are false
  * positives, they are created by gcc. The downside of excluding rodata
  * is that there really are some user references from rodata to
  * init code, e.g. drivers/video/vgacon.c:
- * 
+ *
  * const struct consw vga_con = {
  *        con_startup:            vgacon_startup,
  *
@@ -769,10 +769,10 @@ static int init_section_ref_ok(const cha
 	for (s = namelist1; *s; s++)
 		if (strcmp(*s, name) == 0)
 			return 1;
-	for (s = namelist2; *s; s++)	
+	for (s = namelist2; *s; s++)
 		if (strncmp(*s, name, strlen(*s)) == 0)
 			return 1;
-	for (s = namelist3; *s; s++)	
+	for (s = namelist3; *s; s++)
 		if (strstr(*s, name) != NULL)
 			return 1;
 	return 0;
@@ -792,12 +792,12 @@ static int exit_section(const char *name
 	if (strcmp(name, ".exit.data") == 0)
 		return 1;
 	return 0;
-	
+
 }
 
 /*
  * Identify sections from which references to a .exit section is OK.
- * 
+ *
  * [OPD] Keith Ownes <kaos@sgi.com> commented:
  * For our future {in}sanity, add a comment that this is the ppc .opd
  * section, not the ia64 .opd section.
@@ -829,14 +829,14 @@ static int exit_section_ref_ok(const cha
 		".unwind",  /* Sample: IA_64.unwind.exit.text */
 		NULL
 	};
-	
+
 	for (s = namelist1; *s; s++)
 		if (strcmp(*s, name) == 0)
 			return 1;
-	for (s = namelist2; *s; s++)	
+	for (s = namelist2; *s; s++)
 		if (strncmp(*s, name, strlen(*s)) == 0)
 			return 1;
-	for (s = namelist3; *s; s++)	
+	for (s = namelist3; *s; s++)
 		if (strstr(*s, name) != NULL)
 			return 1;
 	return 0;
@@ -900,7 +900,7 @@ void __attribute__((format(printf, 2, 3)
 	char tmp[SZ];
 	int len;
 	va_list ap;
-	
+
 	va_start(ap, fmt);
 	len = vsnprintf(tmp, SZ, fmt, ap);
 	if (buf->size - buf->pos < len + 1) {
@@ -1129,7 +1129,7 @@ static int dump_sym(struct symbol *sym)
 		return 0;
 	return 1;
 }
-		
+
 static void write_dump(const char *fname)
 {
 	struct buffer buf = { };
@@ -1141,7 +1141,7 @@ static void write_dump(const char *fname
 		while (symbol) {
 			if (dump_sym(symbol))
 				buf_printf(&buf, "0x%08x\t%s\t%s\n",
-					symbol->crc, symbol->name, 
+					symbol->crc, symbol->name,
 					symbol->module->name);
 			symbol = symbol->next;
 		}
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 3b5319d..b14255c 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -13,8 +13,8 @@
 
 #if KERNEL_ELFCLASS == ELFCLASS32
 
-#define Elf_Ehdr    Elf32_Ehdr 
-#define Elf_Shdr    Elf32_Shdr 
+#define Elf_Ehdr    Elf32_Ehdr
+#define Elf_Shdr    Elf32_Shdr
 #define Elf_Sym     Elf32_Sym
 #define Elf_Addr    Elf32_Addr
 #define Elf_Section Elf32_Section
@@ -26,8 +26,8 @@
 #define ELF_R_TYPE  ELF32_R_TYPE
 #else
 
-#define Elf_Ehdr    Elf64_Ehdr 
-#define Elf_Shdr    Elf64_Shdr 
+#define Elf_Ehdr    Elf64_Ehdr
+#define Elf_Shdr    Elf64_Shdr
 #define Elf_Sym     Elf64_Sym
 #define Elf_Addr    Elf64_Addr
 #define Elf_Section Elf64_Section
-- 
1.0.GIT


